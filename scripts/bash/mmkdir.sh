#!/bin/bash

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Path to the binary
BINARY="$SCRIPT_DIR/../../build/mmkdir"

if [ ! -f "$BINARY" ]; then
    echo -e "\e[31mError: mmkdir binary not found in build directory.\e[0m"
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

# Execute the binary with all passed arguments
"$BINARY" "$@"
