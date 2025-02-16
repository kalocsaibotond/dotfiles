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
    <#
    .SYNOPSYS
        Initialise Visual Studio Powershell Development Shell
    .DESCRIPTION
        Tries to find a Launch-VsDevShell.ps1 script in the Visual Studio
        and Build Tools installation directories and runs it.
        If found, a Visual Studio Developer Powershell is initialised
        (or rather launched).
    .PARAMETER
        Any given parameter is passed to the Launch-VsDevShell.ps1 script.
    .EXAMPLE
        PS> Initialize-VsDevShell
    #>
    $Launcher = (
        "C:\Program Files (x86)\Microsoft Visual Studio\*\*\Common7\Tools\" +
        "Launch-VsDevShell.ps1"
    )
    & $Launcher @args @PSBoundParameters
}
