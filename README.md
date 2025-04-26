
# CruncherLite - Custom Wordlist Generator

## Overview

**CruncherLite** is a bash script that generates custom wordlists from an input wordlist file. It applies a variety of patterns including special characters, numerics, and character replacements to generate a wide range of potential password variations.

## Features

- Generates wordlist variations by appending and prepending special characters and numerics to words.
- Supports custom special characters, numbers, and character replacements.
- Handles both uppercase and lowercase first-letter variants automatically.

## Requirements

- A bash environment (Linux/macOS)
- No additional dependencies required

## Usage

### Basic Command

Run the script with the path to the input wordlist file:

```bash
./cruncherLite.sh /path/to/words.txt
```

This will generate a custom wordlist named `custom_wordlist.txt` in the same directory.

### Available Options

- **Special Characters (`special_chars`)**: The script includes the following by default: `@`, `#`, `$`, `!`, `%`, `&`, `*`.
- **Numerics (`numerics`)**: The script includes the following by default: `2025`, `2024`, `2023`, `123`, `321`, `1234`, `12345`, `007`, `999`, `111`.
- **Replacements**: It applies common replacements such as `a -> @`, `s -> $`, `i -> 1`, `o -> 0`, `e -> 3`, etc.

### Sample Commands

1. **Default Command**: Generate a wordlist with default options.
   ```bash
   ./cruncherLite.sh /path/to/words.txt
   ```

2. **Custom Output File**: Specify a custom output file name.
   ```bash
   ./cruncherLite.sh /path/to/words.txt -o custom_output.txt
   ```

3. **Custom Special Characters and Numerics**: Provide custom characters and numerics.
   ```bash
   ./cruncherLite.sh /path/to/words.txt -c "@,#,$,!" -n "2025,1234,5678"
   ```

### Example

If you run the following command with an input file `usernames.txt`:

```bash
./cruncherLite.sh /path/to/usernames.txt
```

The generated `custom_wordlist.txt` will contain variations like:

```
admin@2025
admin#2025
admin$2025
admin!2025
admin%2025
admin&2025
admin*2025
user@2025
user#2025
user$2025
user!2025
...
```

## Advantages

- **Customizable**: Easily modify special characters, numerics, and replacements to suit your needs.
- **Comprehensive Output**: Generates multiple variations of each word with combinations of characters and numerics.
- **Efficient and Easy to Use**: Just provide an input wordlist, and the script generates the variations automatically.
- **No Dependencies**: Runs directly in a bash environment without requiring additional software or libraries.

