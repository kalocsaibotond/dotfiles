$WindowsPowershellProfileLocation = (
    Split-Path -Path $Profile.CurrentUserCurrentHost -Parent
)

."$WindowsPowershellProfileLocation\Variables.ps1"
."$WindowsPowershellProfileLocation\Initialisations.ps1"
."$WindowsPowershellProfileLocation\Functions.ps1"
."$WindowsPowershellProfileLocation\Aliases.ps1"
