$ContextMenuDirRegeditEntries = @(
    "Directory\Background\shell"
    "Directory\shell"
    "Folder\Background\shell"
    "Folder\shell"
    "Drive\shell"
)


function Add-ContextMenuDir
{
    param (
        [Parameter(
            Position = 0,
            Mandatory = $true,
            HelpMessage = "Display name for the context menu option."
        )][string]$DisplayName,
        [Parameter(
            Position = 1,
            Mandatory = $true,
            HelpMessage = "Path to the application executable."
        )][string]$ApplicationPath,
        [Parameter(
            Position = 2,
            HelpMessage = "CLI options to the application executable.
            Note that any written %V will be substiuted
            to the current working directory."
        )][string]$ApplicationArgs="",
        [Parameter(
            Position = 4,
            HelpMessage = "Whether to add to context menu for all users.
            It requres administrator rigths
            because modifications occur in HKCR."
        )][switch]$Global
    )
# https://stackoverflow.com/questions/20449316/how-add-context-menu-item-to-windows-explorer-for-folders
# https://gist.github.com/flyxyz123/53ac952fe94a14482565f1d96e5704d5

    if ($Global){
        if (Test-Path $registryContextMenuLocation){
            Remove-PSDrive HKCR
            New-PSDrive @{
                PSProvider = "registry"
                Root = "HKEY_CLASSES_ROOT"
                Name = "HKCR"
            }
        } else {
            New-PSDrive @{
                PSProvider = "registry" 
                Root = "HKEY_CLASSES_ROOT"
                Name = "HKCR"
            }
        }
        $psDriveClasses = "HKCR:"
    } else {
        $psDriveClasses = "HKCU:\SOFTWARE\Classes"
    }

    foreach($shell in $ContextMenuDirRegeditEntries){
        $registryPath = Join-Path (
            Join-Path $psDriveClasses $shell
        ) $DisplayName

        New-Item -Path $registryPath -Force
        Set-ItemProperty @{
            Path = $registryPath
            Name = "(Default)"
            Value = "Open $DisplayName here"
        }
        Set-ItemProperty @{
            Path = $registryPath
            Name = "Icon"
            Value = "$ApplicationPath"
        }
 
        $commandPath = Join-Path $registryPath "command"
        New-Item -Path $commandPath -Force
        Set-ItemProperty @{
            Path = $commandPath
            Name = "(Default)"
            Value = "$ApplicationPath $ApplicationArgs"
        }
    }
}


function Remove-ContextMenuDir
{
    param (
        [Parameter(
            Position = 0,
            Mandatory = $true,
            HelpMessage = "Display name for the context menu option."
        )][string]$DisplayName,
        [Parameter(
            Position = 3,
            HelpMessage = "Whether to add to context menu for all users.
            It requres administrator rigths because modifications
            occur in HKCR."
        )][switch]$Global

    )

    if ($Global){
        if (Test-Path $registryContextMenuLocation){
            Remove-PSDrive HKCR
            New-PSDrive @{
                PSProvider = "registry"
                Root = "HKEY_CLASSES_ROOT"
                Name = "HKCR"
            }
        } else {
            New-PSDrive @{
                PSProvider = "registry"
                Root = "HKEY_CLASSES_ROOT"
                Name = "HKCR"
            }
        }
        $psDriveClasses = "HKCR:"
    } else {
        $psDriveClasses = "HKCU:\SOFTWARE\Classes"
    }

    foreach($shell in $ContextMenuDirRegeditEntries){
        $registryPath = Join-Path (
            Join-Path $psDriveClasses $shell
        ) $DisplayName
        Remove-Item -Path $registryPath -Force -Recurse
    }
}
