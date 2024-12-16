.$WindowsPowershellProfile

# Loading cross platform PowerShell specific profile
$ProfileLocation = (
    Split-Path -Path $Profile.CurrentUserCurrentHost -Parent
)
