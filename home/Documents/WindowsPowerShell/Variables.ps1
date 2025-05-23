$EnvironmentVariablesSetup = @{
    XDG_DATA_HOME = "$HOME/.local/share"
    XDG_CONFIG_HOME = "$HOME/.config"
    XDG_STATE_HOME = "$HOME/.local/state"
    XDG_CACHE_HOME = "$HOME/.cache"
    EDITOR = "nvim"
    VISUAL = "nvim"
    PAGER = "moar"
    MANPAGER = "moar"
    BAT_PAGER = "moar -no-linenumbers -quit-if-one-screen"
}
$EnvironmentVariablesSetup["BAT_CONFIG_DIR"] = Join-Path `
    -Path $EnvironmentVariablesSetup["XDG_CONFIG_HOME"] `
    -ChildPath "bat"


function Set-EnvironmentVariablesSetup
{
    <#
    .SYNOPSIS
        Set the environment variables of the setup.
    .DESCRIPTION
        This function sets the environment variables of my dotfiles setup
        using the [Environment]::SetEnvironmentVariable function.
    .PARAMETER Scope
        Scope of the environment variable setting. It is passed straight to
        the third, Scope parameter of the
        [Environment]::SetEnvironmentVariable function.
    #>
    param (
        [Parameter(
            Position = 0,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Scope of the environment variable setting. Process
            scope is not persistent while machine and user scope is
            persistent."
        )][string]$Scope = "Process"
    )
    foreach ($env_var_name in $EnvironmentVariablesSetup.keys)
    {
        [Environment]::SetEnvironmentVariable(
            $env_var_name,
            $EnvironmentVariablesSetup[$env_var_name],
            $Scope
        )
    }
}


function Remove-EnvironmentVariablesSetup
{
    <#
    .SYNOPSIS
        Set the environment variables of the setup.
    .DESCRIPTION
        This function sets the environment variables of my dotfiles setup
        using the [Environment]::SetEnvironmentVariable function.
    .PARAMETER Scope
        Scope of the environment variable setting. It is passed straight to
        the third, Scope parameter of the
        [Environment]::SetEnvironmentVariable function.
    #>
    param (
        [Parameter(
            Position = 0,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Scope of the environment variable setting. Process
            scope is not persistent while machine and user scope is
            persistent."
        )][string]$Scope = "Process"
    )
    foreach ($env_var_name in $EnvironmentVariablesSetup.keys)
    {
        [Environment]::SetEnvironmentVariable(
            $env_var_name,
            "",
            $Scope
        )
    }
}
