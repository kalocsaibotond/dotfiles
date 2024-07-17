."..\..\Documents\WindowsPowerShell\Functions.ps1"
."..\..\Documents\WindowsPowerShell\Variables.ps1"

# Install Scoop packages
# NOTE: Scoop is the primary package manager for my environment

if (-Not (Test-Command -Name scoop)){
    Invoke-RestMethod get.scoop.sh | Invoke-Expression
}

scoop install .\scoop_export.json

if (-Not (Test-Command -Name winget)){
    scoop install main/winget
}

# Install Winget packages

winget import `
    .\winget_export.json `
    --accept-source-agreements `
    --accept-package-agreements `
    --disable-interactivity

# Set up configuration

$GitInstallDir = "$(scoop prefix git)"
foreach(
    $Executable in (Get-ChildItem -Path "$GitInstallDir\usr\bin\*.exe")
) {
  scoop shim add $Executable.BaseName $Executable.FullName
}
foreach(
    $Executable in (Get-ChildItem -Path "$GitInstallDir\mingw64\bin\*.exe")
) {
  scoop shim add  $Executable.BaseName $Executable.FullName
}


Set-EnvironmentVariablesSetup -Scope "User"  # Installing environment variables
Add-ContextMenuDir `
    -DisplayName "WezTerm" `
    -ApplicationPath "$(scoop prefix wezterm)\wezterm-gui.exe" `
    -ApplicationArgs 'start --no-auto-connect --cwd "%V"'
Add-ContextMenuDir `
    -DisplayName "Neovim Qt" `
    -ApplicationPath "$(scoop prefix neovim-qt)\bin\nvim-qt.exe" `
    -ApplicationArgs '--maximized -- --cmd "cd %V"'
Add-ContextMenu `
   -DisplayName "Neovim Qt" `
   -ApplicationPath "$(scoop prefix neovim-qt)\bin\nvim-qt.exe" `
   -ApplicationArgs '--maximized "%1"' `
   -Classes '*'

reg import "$(scoop prefix pwsh)\install-explorer-context.reg"
reg import "$(scoop prefix pwsh)\install-explorer-context.reg"  # needs double run to work
reg import "$(scoop prefix pwsh)\install-file-context.reg"

nvm install lts
nvm on
Invoke-Expression "$(scoop prefix nvm)\nodejs\nodejs\npm install -g neovim"

conda init powershell
conda install -y -c conda-forge pynvim

git config --global credential.helper manager
