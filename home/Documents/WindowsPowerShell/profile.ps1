function Initialize-Conda()
{
    <#
    .SYNOPSYS
        Initialise a conda environment.
    .DESCRIPTION
        Wrapper function around the conda initialisation shell code, and also
        activates a conda environment if the name is given.
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
            HelpMessage = "Name of the command to test existence."
        )][string[]]$Environment = ""
    )

    #region conda initialize
    # !! Contents within this block are managed by 'conda init' !!
    If (Test-Path "C:\Users\botond.kalocsai\scoop\apps\anaconda3\current\App\Scripts\conda.exe")
    {
    (& "C:\Users\botond.kalocsai\scoop\apps\anaconda3\current\App\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | ?{$_} | Invoke-Expression
    }
    #endregion

    if("" -ne $Environment)
    {
        conda activate "$Environment"
    }
}
Set-Alias -Name condainit -Value Initialize-Conda -Description "Conda initialisaiton"

