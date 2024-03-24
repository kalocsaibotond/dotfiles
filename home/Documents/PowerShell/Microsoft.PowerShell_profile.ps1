$ProfileLocation = Split-Path -Path $Profile.CurrentUserCurrentHost -Parent

."$ProfileLocation\Variables.ps1"
."$ProfileLocation\Initialisations.ps1"
."$ProfileLocation\Functions.ps1"
