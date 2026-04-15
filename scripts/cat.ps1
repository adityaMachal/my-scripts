param(
    [Parameter(Position=0, ValueFromRemainingArguments=$true)]
    [string[]]$Files,

    [string]$InFile,
    [string]$OutFile,
    [string]$AddFile
)

function Get-MultilineInput {
    $lines = @()
    Write-Host "Input ('--end' to stop):" -ForegroundColor Cyan
    while ($true) {
        $line = Read-Host
        if ($line -ieq '--end') { break }
        $lines += $line
    }
    return $lines
}

# Case 1: Standard Cat behavior (Print files)
if ($Files -and -not $InFile -and -not $OutFile -and -not $AddFile) {
    foreach ($file in $Files) {
        if (Test-Path $file) {
            Get-Content $file
        } else {
            Write-Host "cat: $file: No such file or directory" -ForegroundColor Red
        }
    }
    exit
}

# Conflict check
if ($InFile -and $AddFile) {
    Write-Host "Error: Cannot use both -InFile and -AddFile at the same time." -ForegroundColor Red
    exit
}

# Case 2: Copy InFile to OutFile
if ($InFile -and $OutFile) {
    if (-not (Test-Path $InFile)) {
        Write-Host "File $InFile not found!" -ForegroundColor Red
        exit
    }
    Get-Content $InFile | Set-Content $OutFile
    Write-Host "Copied $InFile to $OutFile successfully." -ForegroundColor Green
    exit
}

# Case 3: Multi-line input to InFile
if ($InFile -and -not $OutFile) {
    $lines = Get-MultilineInput
    $lines | Set-Content $InFile
    Write-Host "Successfully saved contents in $InFile." -ForegroundColor Green
    exit
}

# Case 4: Append input to AddFile
if ($AddFile) {
    if (-not (Test-Path $AddFile)) {
        Write-Host "File $AddFile not found!" -ForegroundColor Red
        exit
    }
    $lines = Get-MultilineInput
    $lines | Add-Content $AddFile
    Write-Host "Successfully appended to $AddFile." -ForegroundColor Green
    exit
}

# Case 5: Show contents of OutFile (Legacy behavior)
if ($OutFile -and -not $InFile -and -not $AddFile) {
    if (-not (Test-Path $OutFile)) {
        Write-Host "File $OutFile not found!" -ForegroundColor Red
        exit
    }
    Get-Content $OutFile
    exit
}

# Default: If no args, show usage
Write-Host "Usage:" -ForegroundColor Cyan
Write-Host "  cat <file1> <file2>          # Print file contents"
Write-Host "  cat -InFile <f1> -OutFile <f2> # Copy f1 to f2"
Write-Host "  cat -InFile <f1>             # Write interactive input to f1"
Write-Host "  cat -AddFile <f1>            # Append interactive input to f1"
