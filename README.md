# My Scripts (Cross-Platform)
A collection of custom C utilities and PowerShell/Bash scripts for productivity on Windows and Linux.

## Project Goal
To provide lightweight, cross-platform command-line tools that behave consistently across operating systems.

## Features
- **Unified C Utilities:** `mmkdir` and `touch` written in C with platform-specific optimizations and robust error handling.
- **Self-Healing Scripts:** Native wrappers that automatically detect missing binaries and prompt for compilation.
- **Enhanced `cat`:** Supports standard file output and advanced interactive input/copy/append features.
- **Cross-Platform Parity:** Core utilities are available in both **PowerShell (`.ps1`)** and **Bash (`.sh`)**.

## Installation & Setup

### 1. Compile the Utilities
Ensure you have `gcc` installed. Run the appropriate script:

- **Windows:** `.\compile.ps1`
- **Linux/macOS:** `./compile.sh`

### 2. Add to PATH
Add the appropriate scripts folder to your system PATH.

#### Windows (PowerShell)
Add this to your `$PROFILE`:
```powershell
$env:Path += ";C:\path\to\my-scripts\scripts\pwsh"
```

#### Linux/macOS (Bash/Zsh)
Add this to your `.bashrc` or `.zshrc`:
```bash
export PATH="$PATH:/path/to/my-scripts/scripts/bash"
```

## Usage

### `mmkdir`
Creates one or more directories.
```bash
mmkdir folder1 folder2
```

### `touch`
Creates or updates one or more files.
```bash
touch file1.txt file2.c
```

### `cat`
```bash
cat <file1> <file2>          # Print file contents (Standard)
cat -InFile <f1> -OutFile <f2> # Copy f1 to f2
cat -InFile <f1>             # Write interactive input to f1
cat -AddFile <f1>            # Append interactive input to f1
```

### `run`
Compiles and runs various programming languages (`C`, `C++`, `Python`, `Go`, `Rust`, `Java`).
```bash
run main.c
```

## License
Open-source under the MIT License. Owned by [Peeyush](https://github.com/Peeyush-04).
