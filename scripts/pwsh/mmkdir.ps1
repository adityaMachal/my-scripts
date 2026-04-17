param (
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$Folders
)

# Potential paths for the binary (Windows .exe or Linux binary)
$exePaths = @(
    "$PSScriptRoot\..\build\mmkdir.exe",
    "$PSScriptRoot\..\build\mmkdir"
)

$foundExe = $null
foreach ($path in $exePaths) {
    if (Test-Path $path) {
        $foundExe = $path
        break
    }
}

if (-not $foundExe) {
    Write-Host "Error: mmkdir binary not found in build directory." -ForegroundColor Red
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
    & $foundExe @Folders
} else {
    Write-Host "Execution aborted. Please compile the program first." -ForegroundColor Yellow
}
