# Loading Windows PowerShell profile
$WindowsPowershellProfile = (
    powershell -NoProfile -Command {
        Write-OutPut -InputObject $($Profile.CurrentUserCurrentHost)
    }
)
$WindowsPowershellProfileLocation = (
    Split-Path -Path $WindowsPowershellProfile -Parent
)
.$WindowsPowershellProfile

# Loading cross platform PowerShell specific profile
$ProfileLocation = (
    Split-Path -Path $Profile.CurrentUserCurrentHost -Parent
)
