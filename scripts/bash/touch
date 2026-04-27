#!/bin/bash

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Path to the binary
BINARY="$SCRIPT_DIR/../../build/touch"

if [ ! -f "$BINARY" ]; then
    echo -e "\e[31mError: touch binary not found in build directory.\e[0m"
    read -p "Would you like to run the compilation script now? (y/n) " choice
    if [[ "$choice" =~ ^[Yy]$ ]]; then
        bash "$SCRIPT_DIR/../../compile.sh"
        if [ ! -f "$BINARY" ]; then
            echo -e "\e[33mCompilation failed or binary still missing.\e[0m"
            exit 1
        fi
    else
        echo -e "\e[33mExecution aborted. Please compile the program first.\e[0m"
        exit 1
    fi
fi

# Check if arguments were passed
if [ $# -eq 0 ]; then
    echo ""
    echo "No files specified."
    echo "Usage: touch <file1> <file2> ..."
    echo ""
    exit 1
fi

# Execute the binary with all passed arguments
"$BINARY" "$@"
