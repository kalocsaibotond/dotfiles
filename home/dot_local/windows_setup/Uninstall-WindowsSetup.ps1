."..\..\Documents\PowerShell\Functions.ps1"
."..\..\Documents\PowerShell\Variables.ps1"

# Cleaning up configuration
Remove-EnvironmentVariablesSetup -Scope "User"  # Remove environment variables
Remove-ContextMenuDir -DisplayName "WezTerm"
Remove-ContextMenuDir -DisplayName "Neovim Qt"
reg import "$(scoop prefix pwsh)\uninstall-explorer-context.reg"
reg import "$(scoop prefix pwsh)\uninstall-file-context.reg"

$Targets = @(chezmoi managed --include files --path-style absolute)
foreach ($Target in $Targets) {
    Remove-Item -Path $Target
}
chezmoi purge

# Cleaning up installations
# NOTE: Only Scoop and Winget remains

$WingetPackages = (
    Get-Content -Path .\winget_export.json -Raw | ConvertFrom-Json
    ).Sources.Packages | Foreach-Object {
        $_.PackageIdentifier
    }
winget uninstall `
    @WingetPackages `
    --purge `
    --accept-source-agreements `
    --accept-package-agreements `
    --silent `
    --disable-interactivity

$ScoopExport = Get-Content -Path .\scoop_export.json -Raw | ConvertFrom-Json
$ScoopPackages = $ScoopExport.apps | Foreach-Object {
    "$($_.Source)/$($_.Name)"
    }
scoop uninstall `
    @ScoopPackages `
    --purge
foreach($bucket in $ScoopExport.buckets) {
    if("main" -ne $bucket.Name){
      scoop bucket rm $bucket.Name
    }
}
