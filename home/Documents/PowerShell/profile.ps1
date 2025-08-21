# Loading Windows PowerShell profile
$WindowsPowershellProfile = (
    powershell -NoProfile -Command {
        Write-OutPut -InputObject $($Profile.CurrentUserCurrentHost)
    }
)
$WindowsPowershellProfileLocation = (
    Split-Path -Path $WindowsPowershellProfile -Parent
)
# . $WindowsPowershellProfileLocation\profile.ps1
