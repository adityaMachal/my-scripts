param (
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$Files
)

if (-not $Files -or $Files.Count -eq 0) {
    Write-Host ""
    Write-Host "No files specified."
    Write-Host "Usage: touch <file1> <file2> ..."
    Write-Host ""
    exit
}

# Potential paths for the binary (Windows .exe or Linux binary)
$exePaths = @(
    "$PSScriptRoot\..\build\touch.exe",
    "$PSScriptRoot\..\build\touch"
)

$foundExe = $null
foreach ($path in $exePaths) {
    if (Test-Path $path) {
        $foundExe = $path
        break
    }
}

if (-not $foundExe) {
    Write-Host "Error: touch binary not found in build directory." -ForegroundColor Red
    $choice = Read-Host "Would you like to run the compilation script now? (Y/N)"
    if ($choice -ieq 'Y') {
        & "$PSScriptRoot\..\compile.ps1"
        if ($LASTEXITCODE -eq 0) {
            # Check again after compilation
            foreach ($path in $exePaths) {
                if (Test-Path $path) {
                    $foundExe = $path
                    break
                }
            }
        }
    }
}

if ($foundExe) {
    & $foundExe @Files
} else {
    Write-Host "Execution aborted. Please compile the program first." -ForegroundColor Yellow
}
