#---------------------------------------------------------------------------
# Python Virtual Environment Manager -- Create Virtual Environment
#---------------------------------------------------------------------------
param (
    [string]$venv_name = 'venv',
    [string]$requirements = '.\requirements*.txt'
)

$ascii_title = @"
                                   _
__ _____ _ ___ __  __ _ _ ___ __ _| |_ ___ 
\ V / -_) ' \ V / / _| '_/ -_) _`` |  _/ -_)
 \_/\___|_||_\_/  \__|_| \___\__,_|\__\___|

"@

# Ascii title
Write-Host $ascii_title -ForegroundColor Green

# Define venv_abspath from current folder and venv folder
$venv_abspath = Join-Path -Path $PWD -ChildPath $venv_name
Write-Host "Path: $venv_abspath`n" -ForegroundColor Cyan

# ~~~~~~ Start - Precondition Checks ~~~~~~

# (1) Check $PWD is at project root - must have at least one requirements file
if ((Get-ChildItem -Path $PWD -Filter $requirements).Count -lt 1) # -or -not (Test-Path -Path ".git"))
{
    Write-Host "ERROR: Ensure that you're in that project root folder." -ForegroundColor Red
    exit 1
}

# (2) If folder exists, but isn't a venv folder
if ((Test-Path -Path $venv_abspath) -and -not (Test-Path -Path "$venv_abspath\*" -PathType Leaf -Include 'pyvenv.cfg'))
{ 
    Write-Host "ERROR: Folder exists, but is not a venv folder." -ForegroundColor Red
    exit 2
}

# (3) Check for multiple venv folders
$venv_folders = Get-ChildItem -Path $PWD -Filter 'pyvenv.cfg' -Recurse
if ($venv_folders.Count -gt 1)
{
    Write-Host "ERROR: Multiple venv folders found: $($_.Directory)" -ForegroundColor Red
    $venv_folders | Select-Object -Property Directory | ForEach-Object {
        Write-Host "- $($_.Directory)" -ForegroundColor Red
    }
    exit 3
}

# (4) Deactivate virtual environment
if ($env:VIRTUAL_ENV)
{
    Write-Host "Deactivating virtual environment" -ForegroundColor Green
    deactivate
}

# (5) Check for running processes - May not be required if venv is deactivated
#$venv_proc = Get-Process | Where-Object { $_.Path -like "$($venv_abspath)*" }
#if ($venv_proc.Length -gt 0)
#{
#    $venv_proc | Select-Object *
#    Write-Host "ERROR: venv folder contains running processes" -ForegroundColor Red
#    exit 5
#}

# ~~~~~~ End - Precondition Checks ~~~~~~

# Create new virtual environment folder
Write-Host "Creating virtual environment" -ForegroundColor Green
& python.exe -m venv $venv_abspath --clear

# Activate virtual environment
Write-Host "Activating virtual environment" -ForegroundColor Green
& "$venv_abspath\Scripts\activate.ps1"

# Install libraries
Write-Host "Installing libraries:" -ForegroundColor Green
Get-ChildItem -Path $requirements -Recurse | ForEach-Object {
    Write-Host "---- $($_.Name) ----" -ForegroundColor Green
    & pip.exe install -r $_.FullName --disable-pip-version-check --require-virtualenv --no-cache-dir
}

# Display installed libraries
Write-Host "`n---------------------------------------------------------------------" -ForegroundColor Green
Write-Host "pip freeze" -ForegroundColor Green
Write-Host "---------------------------------------------------------------------" -ForegroundColor Green
& pip.exe freeze
Write-Host "`n`n"
exit 0