#!/bin/bash

# Check for the correct number of arguments and file existence
[ "$#" -ne 1 ] && { echo "Usage: $0 <path_to_words_file>"; exit 1; }
[ ! -f "$1" ] && { echo "Error: File '$1' not found."; exit 1; }

# Read words from the input file and generate both upper case and lower case first letter variants
mapfile -t words < <(awk '{print toupper(substr($0,1,1)) tolower(substr($0,2)) "\n" tolower(substr($0,1,1)) tolower(substr($0,2))}' "$1")

# Define special characters, numerics, and replacements
special_chars=('@' '#' '$' '!' '%' '&' '*')
numerics=("2025" "2024" "2023" "123" "321" "1234" "12345" "007" "999" "111")
declare -A replacements=( ["a"]="@" ["s"]="$" ["i"]="1" ["o"]="0" ["e"]="3" ["l"]="1" ["A"]="@" ["S"]="$" ["I"]="1" ["O"]="0" ["E"]="3" ["L"]="1" )

# Function to apply replacements
apply_replacements() { 
    local word=$1
    for key in "${!replacements[@]}"; do 
        word=${word//${key}/${replacements[$key]}}
    done
    echo "$word"
}

# Output file for the final wordlist
output_file="custom_wordlist.txt"
> "$output_file"

# Combine words with multiple patterns
for word in "${words[@]}"; do
    replaced_word=$(apply_replacements "$word")
    
    for numeric in "${numerics[@]}"; do
        for char in "${special_chars[@]}"; do
            # Word + special char + numeric
            echo "${word}${char}${numeric}" >> "$output_file"
            echo "${replaced_word}${char}${numeric}" >> "$output_file"
            
            # Word + numeric + special char
            echo "${word}${numeric}${char}" >> "$output_file"
            echo "${replaced_word}${numeric}${char}" >> "$output_file"
        done

        # Word + numeric (without special char)
        echo "${word}${numeric}" >> "$output_file"
        echo "${replaced_word}${numeric}" >> "$output_file"
    done

    for char in "${special_chars[@]}"; do
        # Word + special char (without numeric)
        echo "${word}${char}" >> "$output_file"
        echo "${replaced_word}${char}" >> "$output_file"
    done
done

echo "Custom wordlist generated in $output_file"
