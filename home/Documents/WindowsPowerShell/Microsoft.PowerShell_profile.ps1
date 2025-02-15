if ("Core" -eq $PSEdition)
{
    $ProfileLocation = $WindowsPowershellProfileLocation
} else
{
    $ProfileLocation = (
        Split-Path -Path $Profile.CurrentUserCurrentHost -Parent
    )
}

."$ProfileLocation\Variables.ps1"
."$ProfileLocation\Initialisations.ps1"
."$ProfileLocation\Functions.ps1"
."$ProfileLocation\Aliases.ps1"
