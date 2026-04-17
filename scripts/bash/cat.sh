#!/bin/bash

# Default values
IN_FILE=""
OUT_FILE=""
ADD_FILE=""
FILES=()

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -InFile)
            IN_FILE="$2"
            shift 2
            ;;
        -OutFile)
            OUT_FILE="$2"
            shift 2
            ;;
        -AddFile)
            ADD_FILE="$2"
            shift 2
            ;;
        -*)
            echo "Unknown option: $1"
            exit 1
            ;;
        *)
            FILES+=("$1")
            shift
            ;;
    esac
done

function get_multiline_input {
    echo -e "\e[36mInput ('--end' to stop):\e[0m"
    while true; do
        read -r line
        if [[ "$line" == "--end" ]]; then
            break
        fi
        echo "$line"
    done
}

# Case 1: Standard Cat behavior (Print files)
if [[ ${#FILES[@]} -gt 0 && -z "$IN_FILE" && -z "$OUT_FILE" && -z "$ADD_FILE" ]]; then
    for file in "${FILES[@]}"; do
        if [[ -f "$file" ]]; then
            cat "$file"
        else
            echo -e "\e[31mcat: $file: No such file or directory\e[0m"
        fi
    done
    exit 0
fi

# Conflict check
if [[ -n "$IN_FILE" && -n "$ADD_FILE" ]]; then
    echo -e "\e[31mError: Cannot use both -InFile and -AddFile at the same time.\e[0m"
    exit 1
fi

# Case 2: Copy InFile to OutFile
if [[ -n "$IN_FILE" && -n "$OUT_FILE" ]]; then
    if [[ ! -f "$IN_FILE" ]]; then
        echo -e "\e[31mFile $IN_FILE not found!\e[0m"
        exit 1
    fi
    cp "$IN_FILE" "$OUT_FILE"
    echo -e "\e[32mCopied $IN_FILE to $OUT_FILE successfully.\e[0m"
    exit 0
fi

# Case 3: Multi-line input to InFile
if [[ -n "$IN_FILE" && -z "$OUT_FILE" ]]; then
    get_multiline_input > "$IN_FILE"
    echo -e "\e[32mSuccessfully saved contents in $IN_FILE.\e[0m"
    exit 0
fi

# Case 4: Append input to AddFile
if [[ -n "$ADD_FILE" ]]; then
    if [[ ! -f "$ADD_FILE" ]]; then
        echo -e "\e[31mFile $ADD_FILE not found!\e[0m"
        exit 1
    fi
    get_multiline_input >> "$ADD_FILE"
    echo -e "\e[32mSuccessfully appended to $ADD_FILE.\e[0m"
    exit 0
fi

# Case 5: Show contents of OutFile (Legacy behavior)
if [[ -n "$OUT_FILE" && -z "$IN_FILE" && -z "$ADD_FILE" ]]; then
    if [[ ! -f "$OUT_FILE" ]]; then
        echo -e "\e[31mFile $OUT_FILE not found!\e[0m"
        exit 1
    fi
    cat "$OUT_FILE"
    exit 0
fi

# Default: Usage
echo -e "\e[36mUsage:\e[0m"
echo "  cat <file1> <file2>          # Print file contents"
echo "  cat -InFile <f1> -OutFile <f2> # Copy f1 to f2"
echo "  cat -InFile <f1>             # Write interactive input to f1"
echo "  cat -AddFile <f1>            # Append interactive input to f1"
