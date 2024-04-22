# Loading Windows PowerShell profile
$WindowsPowershellProfile = (
    powershell -NoProfile -Command {
        Write-OutPut -InputObject $($Profile.CurrentUserCurrentHost)
    }
)
.$WindowsPowershellProfile

# Loading Cross Platform powershell specific profile
$PwshProfileLocation = (
    Split-Path -Path $Profile.CurrentUserCurrentHost -Parent
)
