function Start-PluginlessNeovim
{
    nvim.exe -u $ENV:XDG_CONFIG_HOME\nvim-pluginless\init.vim `
        @args `
        @PSBoundParameters
}
Set-Alias `
    -Name pvim `
    -Value Start-PluginlessNeovim `
    -Description "Neovim With a pluginless config."


function Start-EzaWithIcons
{
    eza.exe --icons=auto @args @PSBoundParameters 
}
Set-Alias `
    -Name eza `
    -Value Start-EzaWithIcons `
    -Description "Eza with icons on."

function Start-EzaWithPager
{
    eza.exe --colour=always --icons=always --classify=always `
        @args @PSBoundParameters | moar
}
Set-Alias `
    -Name ezap `
    -Value Start-EzaWithPager `
    -Description "Eza with pager."

function Start-FdWithPager
{
    fd.exe --color always @args @PSBoundParameters | moar
}
Set-Alias `
    -Name fdp `
    -Value Start-FdWithPager `
    -Description "Fd with pager."

function Start-RgWithPager
{
    rg.exe --pretty @args @PSBoundParameters | moar -no-linenumbers
}
Set-Alias `
    -Name rgp `
    -Value Start-RgWithPager `
    -Description "Rg with pager."

function Start-DifftWithPager
{
    difft.exe --color always @args @PSBoundParameters | moar -no-linenumbers
}
Set-Alias `
    -Name difftp `
    -Value Start-DifftWithPager `
    -Description "difft with pager."

function Restart-Workspacer
{
    Stop-Process -Name workspacer*
    Start-Process workspacer
}
Set-Alias `
    -Name rws `
    -Value Restart-Workspacer `
    -Description "Start or rather restart workspacer tiling window manager."

Set-Alias `
    -Name condainit `
    -Value Initialize-Conda `
    -Description "Conda initialisaiton"

Set-Alias `
    -Name vsdevsh `
    -Value Initialize-VsDevShell `
    -Description "Initialise Visual Studio developer shell."
