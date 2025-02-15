# Setting up zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })


function Initialize-Conda
{
    <#
    .SYNOPSYS
        Initialise a conda environment.
    .DESCRIPTION
        Wrapper function around the conda initialisation shell code, and also
        activates a conda environment if its name is given.
    .PARAMETER Environment
        The name of the conda environment that we wish to activate.
    .EXAMPLE
        PS> Initialize-Conda base
    #>
    param (
        [Parameter(
            Position = 0,
            Mandatory = $false,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Name of the conda environment to activate."
        )][string[]]$Environment = ""
    )

    $CondaPath = (Get-Command -Name "conda").Source
    If (Test-Path $CondaPath)
    {
        (& $CondaPath "shell.powershell" "hook") |
            Out-String | Where-Object {$_} | Invoke-Expression
    }

    if("" -ne $Environment)
    {
        conda activate "$Environment"
    }
}


function Initialize-VsDevShell
{
    & ("C:\Program Files (x86)\Microsoft Visual Studio\*\*\Common7\Tools\" +
        "Launch-VsDevShell.ps1") @args @PSBoundParameters
}
