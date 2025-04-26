# CruncherLite - Custom Wordlist Generator

CruncherLite is a flexible script that allows you to create customized wordlists by combining words with numerics, special characters, and applying replacements. This script provides options to configure the wordlist generation based on user-defined input such as custom characters, length limits, and keywords.

## Features

- Generate wordlist from an input file or comma-separated list of keywords.
- Support for adding numerics, special characters, and custom replacements.
- Option to set minimum and maximum length for generated words.
- Output the generated wordlist to a custom file.

## Installation

No installation required. Just download the script and make it executable.

```bash
chmod +x cruncherLite.sh
```

## Usage

### 1. Generate Wordlist from Input File

```bash
./cruncherLite.sh /path/to/words.txt -c "@,#,$,!" -n "2025,1234" -m 6 -M 12 -o custom_output.txt
```

### 2. Generate Wordlist from Keywords

```bash
./cruncherLite.sh -w "admin,user,test" -c "@,#" -n "1234,9999" -m 6 -M 10 -o custom_output.txt
```

### 3. Generate Wordlist with Default Settings

```bash
./cruncherLite.sh -w "admin,user"
```

## Arguments

| Option  | Description                                                                                          |
| ------- | ---------------------------------------------------------------------------------------------------- |
| `-w`    | Comma-separated list of keywords to generate the wordlist.                                           |
| `-c`    | Comma-separated list of special characters to append to or prepend to the words (default: `@,#,$,!`). |
| `-n`    | Comma-separated list of numerics to append to or prepend to the words (default: `2025,1234`).         |
| `-m`    | Minimum length of the generated words.                                                                |
| `-M`    | Maximum length of the generated words.                                                                |
| `-o`    | Custom output file name for the generated wordlist.                                                   |

## Example

Generate wordlist from an input file (`words.txt`) with special characters `@,#,$`, numerics `2025,1234`, and word length between 6 and 12:

```bash
./cruncherLite.sh words.txt -c "@,#,$" -n "2025,1234" -m 6 -M 12 -o output.txt
```

Generate wordlist from a list of keywords (`admin,user,test`), with numerics and a minimum word length of 6:

```bash
./cruncherLite.sh -w "admin,user,test" -c "@,#" -n "1234,5678" -m 6 -M 10 -o mylist.txt
