#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: run <file>"
    exit 1
fi

FILE="$1"

if [ ! -f "$FILE" ]; then
    echo "File not found: $FILE"
    exit 1
fi

FILENAME=$(basename -- "$FILE")
EXTENSION="${FILENAME##*.}"
BASENAME="${FILENAME%.*}"

function writer() {
    echo "Successfully Compiled"
    echo -e "\nRunning...\n"
}

case "$EXTENSION" in
    c)
        echo "Compiling C..."
        gcc "$FILE" -o "$BASENAME"
        if [ $? -eq 0 ]; then
            writer
            ./"$BASENAME"
        else
            echo "Compilation failed"
            exit 1
        fi
        ;;
    cpp)
        echo "Compiling C++..."
        # Detect GCC version for std flag
        GCC_VER=$(g++ -dumpversion | cut -d. -f1)
        if [ "$GCC_VER" -ge 13 ]; then
            STD="-std=c++23"
        elif [ "$GCC_VER" -ge 11 ]; then
            STD="-std=c++20"
        elif [ "$GCC_VER" -ge 8 ]; then
            STD="-std=c++17"
        else
            STD="-std=c++11"
        fi
        echo "Detected GCC v$GCC_VER. Using flag: $STD"
        g++ "$FILE" -O3 -Wall -Wextra $STD -o "$BASENAME"
        if [ $? -eq 0 ]; then
            writer
            ./"$BASENAME"
        else
            echo "Compilation failed"
            exit 1
        fi
        ;;
    java)
        echo "Compiling Java..."
        javac "$FILE"
        if [ $? -eq 0 ]; then
            writer
            java "$BASENAME"
        else
            echo "Compilation failed"
            exit 1
        fi
        ;;
    py)
        echo "Executing Python..."
        python3 "$FILE"
        ;;
    go)
        echo "Executing Go..."
        go run "$FILE"
        ;;
    rs)
        echo "Compiling Rust..."
        rustc "$FILE" -o "$BASENAME"
        if [ $? -eq 0 ]; then
            writer
            ./"$BASENAME"
        else
            echo "Compilation failed"
            exit 1
        fi
        ;;
    *)
        echo "File format not supported: $EXTENSION"
        exit 1
        ;;
esac

echo -e "\nExecuted Successfully"
