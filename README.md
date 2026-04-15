# My Scripts (Cross-Platform)
A collection of custom C utilities and PowerShell scripts for productivity on Windows and Linux.

## Project Goal
To provide lightweight, cross-platform command-line tools that behave consistently across operating systems.

## Features
- **Unified C Utilities:** `mmkdir` and `touch` written in C with platform-specific optimizations and robust error handling.
- **Self-Healing Scripts:** PowerShell wrappers that automatically detect missing binaries and prompt for compilation.
- **Enhanced `cat.ps1`:** Supports standard file output and advanced interactive input/copy/append features.
- **Cross-Platform:** Core utilities work on Windows, Linux, and macOS.

## Installation & Setup

### 1. Compile the Utilities
Ensure you have `gcc` installed. Run the appropriate script:

- **Windows (PowerShell):**
  ```powershell
  .\compile.ps1
  ```
- **Linux/macOS (Bash):**
  ```bash
  chmod +x compile.sh
  ./compile.sh
  ```

### 2. Add to PATH
Add the `scripts` folder to your system PATH to run the tools from anywhere.

#### Windows (PowerShell)
Add this line to your `$PROFILE`:
```powershell
$env:Path += ";C:\path\to\my-scripts\scripts"
```

#### Linux/macOS (Bash/Zsh)
Add this line to your `.bashrc` or `.zshrc`:
```bash
export PATH="$PATH:/path/to/my-scripts/scripts"
```
*(Note: On Linux, you may also want to add the `build` directory to your PATH to run the compiled binaries directly.)*

## Usage

### `mmkdir`
Creates one or more directories.
```powershell
mmkdir folder1 folder2 folder3
```

### `touch`
Creates or updates one or more files.
```powershell
touch file1.txt file2.c
```

### `cat` (PowerShell)
```powershell
cat <file1> <file2>          # Print file contents (Standard)
cat -InFile <f1> -OutFile <f2> # Copy f1 to f2
cat -InFile <f1>             # Write interactive input to f1
cat -AddFile <f1>            # Append interactive input to f1
```

## License
Open-source under the MIT License. Owned by [Peeyush](https://github.com/Peeyush-04).
