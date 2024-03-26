$ContextMenuDirRegeditEntries = @(
    "Directory\Background\shell"
    "Directory\shell"
    "Folder\Background\shell"
    "Folder\shell"
    "Drive\shell"
)  # For Add-ContextMenuDir and Remove-ContextMenuDir


function Test-Command
{
    <#
    .SYNOPSIS
        Command existence tester.
    .DESCRIPTION
        Test whether a command exist or not.
    .PARAMETER Name
        The name of the command to test.
    .EXAMPLE
        PS> Test-Command -Name "winget"
    #>
    [cmdletbinding()]
    param (
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Name of the command to test existence."
        )][string[]]$Name
    )
    PROCESS {
        foreach ($n in $Name) {
            [bool](Get-Command -Name $n -ErrorAction SilentlyContinue)
        }
    }
}


function Get-RegistryClasses
{
    <#
    .SYNOPSIS
        Get rhe registry PS drive  location for the directory context menu.
    .DESCRIPTION
        Get rhe registry PS drive location for the directory context menu
        if it exists. If the PS drive does not exists then it also sets it
        up.
    .PARAMETER Global
        Whether we want to add the context meny entry for all users.
    .PARAMETER Scope
        The scope of the registry PS drive's existence.
    #>
    param (
        [Parameter(
            Position = 0,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "The scope of the registry PS drive. It is passed
            directly to the New-PSDrive cmdlet's Scope argument."
        )][string]$Scope = "1",
        [Parameter(
            Position = 1,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Whether to add to context menu for all users.
            It requres administrator rigths
            because modifications occur in HKCR."
        )][switch]$Global
    )
    if ($Global){
        $ClassDrives = Get-PSDrive -PSProvider "registry" | Where-Object {
            $_.Root -eq "HKEY_CLASSES_ROOT"
        }
        if ($ClassDrives){  # If already exists then use it
            return $ClassDrives[0].Name + ":"
        } else {
            New-PSDrive `
                -Name "Classes" `
                -PSProvider "registry" `
                -Root "HKEY_CLASSES_ROOT" `
                -Scope $Scope | Out-Null
        }
    } else {
        $ClassDrives = Get-PSDrive -PSProvider "registry" | Where-Object {
            $_.Root -eq "HKEY_CURRENT_USER\SOFTWARE\Classes"
        }
        if ($ClassDrives){  # If already exists then use it
            return $ClassDrives[0].Name + ":"
        } else {
            New-PSDrive `
                -Name "Classes" `
                -PSProvider "registry" `
                -Root "HKEY_CURRENT_USER\SOFTWARE\Classes" `
                -Scope $Scope | Out-Null
        }
    }
    return "Classes:"
}


function Add-ContextMenuDir
{
    <#
    .SYNOPSIS
        Add directory context menu item.
    .DESCRIPTION
        This command modifies the registry to add a context menu item.
        The context menu item will be put to the context menu part that is for
        directories, folders and alike.
        For example when in the file exploler, one clics at a directory, the
        the adde context menu will apper.
    .PARAMETER DisplayName
        The display name of the application that
        we want to put into the context menu.
    .PARAMETER ApplicationPath
        The path of the executable application.
    .PARAMETER ApplicationArgs
        Command line arguments for the executable application.
        These are jus put after the application path, after a whitespace.
        The registry applies here its automatic string formatting.
        For example the substring %V will be substituted with the directory
        and alike.
    .PARAMETER Global
        Whether to add to context menu for all users. This requires 
        administrator rights.
    .LINK
        https://stackoverflow.com/questions/20449316/how-add-context-menu-item-to-windows-explorer-for-folders
    .LINK
        https://gist.github.com/flyxyz123/53ac952fe94a14482565f1d96e5704d5
    #>
    [cmdletbinding()]
    param (
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Display name for the context menu option."
        )][string]$DisplayName,
        [Parameter(
            Position = 1,
            Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Path to the application executable."
        )][string]$ApplicationPath,
        [Parameter(
            Position = 2,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "CLI options to the application executable.
            Note that any written %V will be substiuted
            to the current working directory."
        )][string]$ApplicationArgs="",
        [Parameter(
            Position = 4,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Whether to add to context menu for all users.
            It requres administrator rigths
            because modifications occur in HKCR."
        )][switch]$Global
    )
    BEGIN {
        $RegistryClasses = Get-RegistryClasses -Scope "2" -Global $Global
    }
    PROCESS {
        foreach($n in $DisplayName){
            foreach($shell in $ContextMenuDirRegeditEntries){
                $RegistryPath = Join-Path -Path (
                    Join-Path -Path $RegistryClasses -ChildPath $shell
                ) -ChildPath $n

                New-Item -Path $RegistryPath -Force
                Set-ItemProperty `  # Setting display text
                    -Path $RegistryPath `
                    -Name "(Default)" `
                    -Value "Open $DisplayName here"
                Set-ItemProperty `  # Setting icon
                    -Path $RegistryPath `
                    -Name "Icon" `
                    -Value "$ApplicationPath"

                $commandPath = Join-Path `
                    -Path $RegistryPath `
                    -ChildPath "command"
                New-Item -Path $commandPath -Force
                Set-ItemProperty `  # Setting command to run
                    -Path $commandPath `
                    -Name "(Default)" `
                    -Value "$ApplicationPath $ApplicationArgs"
            }
        }
    }
}


function Remove-ContextMenuDir
{
    <#
    .SYNOPSIS
        Remove directory context menu item.
    .DESCRIPTION
        Reverse the effect of the Add-ContextMenuDir command.
        The registry entry is identified with the DisplayName parameter.
    .PARAMETER DisplayName
        The display name of the application that
        we want to put into the context menu.
    .PARAMETER Global
        Whether to remove from context menu for all users. This requires 
        administrator rights.
    .EXAMPLE
        Remove-ContextMenuDir -DisplayName "WezTerm"
    #>
    [cmdletbinding()]
    param (
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Display name for the context menu option."
        )][string[]]$DisplayName,
        [Parameter(
            Position = 3,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Whether to add to context menu for all users.
            It requres administrator rigths because modifications
            occur in HKCR."
        )][switch]$Global

    )
    BEGIN {
        $RegistryClasses = Get-RegistryClasses -Scope "2" -Global $Global
    }
    PROCESS { 
        foreach($n in $DisplayName){
            foreach($shell in $ContextMenuDirRegeditEntries){
                $RegistryPath = Join-Path -Path (
                    Join-Path -Path $RegistryClasses -ChildPath $shell
                ) -ChildPath $n
                Remove-Item -Path $RegistryPath -Force -Recurse
            }
        }
    }
}
