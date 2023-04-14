#---------------------------------------------------------------------------
# Python Virtual Environment Manager -- Activate Virtual Environment
#---------------------------------------------------------------------------

$AsciiText = 
@"
                           _   _          _
__ _____ _ ___ __  __ _ __| |_(_)_ ____ _| |_ ___
\ V / -_) ' \ V / / _`` / _|  _| \ V / _`` |  _/ -_)
 \_/\___|_||_\_/  \__,_\__|\__|_|\_/\__,_|\__\___|

"@

Write-Host $AsciiText -ForegroundColor Green

# Find venv folder
$venv_folder = (Get-ChildItem -Path $PWD -Filter "pyvenv.cfg" -Depth 1).Directory

# Ensure that we're in the project root folder
if (($venv_folder).Count -eq 1)
{
    Write-Host "Activating virtual environment ... " -NoNewline
    try
    {
        # Activate virtual environment
        & "$venv_folder\Scripts\activate.ps1"
        Write-Host "DONE`n" -ForegroundColor Green
    }
    catch
    {
        Write-Host "FAILED`n$venv_folder" -ForegroundColor Red
    }
}
else
{
    Write-Host "ERROR: Ensure you're in the project root folder.`n" -ForegroundColor Red
}
