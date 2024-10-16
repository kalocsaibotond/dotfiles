function Start-PluginlessNeovim {
    nvim.exe @args `
        -u $ENV:XDG_CONFIG_HOME\nvim-pluginless\init.vim `
        @PSBoundParameters
}
Set-Alias `
    -Name pvim `
    -Value Start-PluginlessNeovim `
    -Description "Neovim With a pluginless config."


function Start-EzaWithIcons {
   eza.exe @args @PSBoundParameters --icons=auto
}
Set-Alias `
    -Name eza `
    -Value Start-EzaWithIcons `
    -Description "Eza bit with icons on."

function Restart-Workspacer {
    Stop-Process -Name workspacer*
    Start-Process workspacer
}
Set-Alias `
    -Name rws `
    -Value Restart-Workspacer `
    -Description "Start or rather restart workspacer tiling window manager."
