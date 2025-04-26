#!/bin/bash

# Function to show usage
usage() {
    echo "Usage:"
    echo "  $0 <path_to_words_file> [-w words] [-c special_chars] [-n numerics] [-m min_length] [-M max_length] [-o output_file]"
    echo ""
    echo "Examples:"
    echo "  $0 words.txt -c '@,#,$' -n '2025,1234' -m 6 -M 12 -o mylist.txt"
    echo "  $0 -w 'admin,user,test' -c '@,#' -n '1234,9999' -m 6 -M 10 -o keywords_list.txt"
    exit 1
}

# Default special characters and numerics
special_chars=('@' '#' '$' '!' '%' '&' '*')
numerics=("2025" "2024" "2023" "123" "321" "1234" "12345" "007" "999" "111")
min_length=""
max_length=""
output_file="custom_wordlist.txt"
input_words=()

# Parse arguments
if [[ "$#" -lt 1 ]]; then
    usage
fi

if [[ "$1" != -* ]]; then
    words_file="$1"
    shift
fi

while [[ $# -gt 0 ]]; do
    case "$1" in
        -w)
            IFS=',' read -r -a input_words <<< "$2"
            shift 2
            ;;
        -c)
            IFS=',' read -r -a special_chars <<< "$2"
            shift 2
            ;;
        -n)
            IFS=',' read -r -a numerics <<< "$2"
            shift 2
            ;;
        -m)
            min_length="$2"
            shift 2
            ;;
        -M)
            max_length="$2"
            shift 2
            ;;
        -o)
            output_file="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
done

# Prepare words list
words=()

if [[ ${#input_words[@]} -gt 0 ]]; then
    for word in "${input_words[@]}"; do
        words+=("$(tr '[:upper:]' '[:lower:]' <<< "${word:0:1}")${word:1}")
        words+=("$(tr '[:lower:]' '[:upper:]' <<< "${word:0:1}")${word:1}")
    done
elif [[ -n "$words_file" ]]; then
    if [[ ! -f "$words_file" ]]; then
        echo "Error: File '$words_file' not found."
        exit 1
    fi
    mapfile -t words < <(awk '{print toupper(substr($0,1,1)) tolower(substr($0,2)) "\n" tolower(substr($0,1,1)) tolower(substr($0,2))}' "$words_file")
else
    echo "Error: No input words or file provided."
    usage
fi

# Define replacements
declare -A replacements=( ["a"]="@" ["s"]="$" ["i"]="1" ["o"]="0" ["e"]="3" ["l"]="1" ["A"]="@" ["S"]="$" ["I"]="1" ["O"]="0" ["E"]="3" ["L"]="1" )

# Function to apply replacements
apply_replacements() {
    local word=$1
    for key in "${!replacements[@]}"; do
        word=${word//${key}/${replacements[$key]}}
    done
    echo "$word"
}

# Helper function to check min and max length
length_valid() {
    local len=$1
    if { [ -z "$min_length" ] || [ "$len" -ge "$min_length" ]; } && { [ -z "$max_length" ] || [ "$len" -le "$max_length" ]; }; then
        return 0
    else
        return 1
    fi
}

# Output file
> "$output_file"

# Combine words with patterns
for word in "${words[@]}"; do
    replaced_word=$(apply_replacements "$word")

    for numeric in "${numerics[@]}"; do
        for char in "${special_chars[@]}"; do
            combos=(
                "${word}${char}${numeric}"
                "${replaced_word}${char}${numeric}"
                "${word}${numeric}${char}"
                "${replaced_word}${numeric}${char}"
            )
            for combo in "${combos[@]}"; do
                if length_valid "${#combo}"; then
                    echo "$combo" >> "$output_file"
                fi
            done
        done

        combos=(
            "${word}${numeric}"
            "${replaced_word}${numeric}"
        )
        for combo in "${combos[@]}"; do
            if length_valid "${#combo}"; then
                echo "$combo" >> "$output_file"
            fi
        done
    done

    for char in "${special_chars[@]}"; do
        combos=(
            "${word}${char}"
            "${replaced_word}${char}"
        )
        for combo in "${combos[@]}"; do
            if length_valid "${#combo}"; then
                echo "$combo" >> "$output_file"
            fi
        done
    done
done

echo "✅ Custom wordlist generated: $output_file"
