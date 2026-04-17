# My Scripts Installer for Windows
$ErrorActionPreference = "Stop"

Write-Host "=> Starting installation..." -ForegroundColor Cyan

# 1. Check for CMake
if (-not (Get-Command cmake -ErrorAction SilentlyContinue)) {
    Write-Host "Error: cmake is not installed or not in PATH." -ForegroundColor Red
    Write-Host "Please install CMake from https://cmake.org/download/"
    exit 1
}

# 2. Build the project
Write-Host "=> Compiling utilities..." -ForegroundColor Cyan
if (-not (Test-Path build)) { New-Item -ItemType Directory build }
cd build
cmake ..
cmake --build . --config Release
cd ..

Write-Host "=> Compilation successful!" -ForegroundColor Green

# 3. Setup PATH instructions
$ScriptPath = Join-Path $PSScriptRoot "scripts\pwsh"

Write-Host "`n=> To complete setup, add the scripts to your PATH:" -ForegroundColor Yellow
Write-Host "Run this command to update your PowerShell Profile:" -ForegroundColor White
Write-Host "Add-Content `$PROFILE '`n`$env:Path += `";$ScriptPath`"'" -ForegroundColor Gray

Write-Host "`nInstallation script finished!" -ForegroundColor Green
