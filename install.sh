#!/bin/bash

# My Scripts Installer for Linux/macOS
set -e

echo -e "\e[36m=> Starting installation...\e[0m"

# 1. Check for CMake
if ! command -v cmake &> /dev/null; then
    echo -e "\e[31mError: cmake is not installed.\e[0m"
    echo "Please install it using your package manager (e.g., sudo apt install cmake)."
    exit 1
fi

# 2. Build the project
echo -e "\e[36m=> Compiling utilities...\e[0m"
mkdir -p build
cd build
cmake ..
make
cd ..

echo -e "\e[32m=> Compilation successful!\e[0m"

# 3. Setup PATH instructions
SCRIPT_PATH="$(pwd)/scripts/bash"
SHELL_RC=""

if [[ "$SHELL" == */zsh ]]; then
    SHELL_RC="$HOME/.zshrc"
elif [[ "$SHELL" == */bash ]]; then
    SHELL_RC="$HOME/.bashrc"
fi

echo -e "\n\e[33m=> To complete setup, add the scripts to your PATH:\e[0m"
if [ -n "$SHELL_RC" ]; then
    echo -e "Run this command to update your $SHELL_RC:"
    echo -e "\e[1;37mecho 'export PATH=\"\$PATH:$SCRIPT_PATH\"' >> $SHELL_RC && source $SHELL_RC\e[0m"
else
    echo -e "Add this directory to your PATH: \e[1;37m$SCRIPT_PATH\e[0m"
fi

echo -e "\n\e[32mInstallation script finished!\e[0m"
