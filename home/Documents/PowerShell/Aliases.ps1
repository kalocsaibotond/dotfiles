function Start-EzaWithIcons {
   eza.exe @args @PSBoundParameters --icons=auto
}
Set-Alias `
    -Name eza `
    -Value Start-EzaWithIcons `
    -Description "eza bit with icons on"
