. $WindowsPowershellProfile

# Loading cross platform PowerShell specific profile
$ProfileLocation = (
    Split-Path -Path $Profile.CurrentUserCurrentHost -Parent
)

if (Test-Path -Path "$ProfileLocation/Profile/"){
    $ScriptFiles = Get-ChildItem -Path "$ProfileLocation/Profile/*.ps1"
    foreach($ScriptFile in $ScriptFiles){
         . $ScriptFile.FullName
    }
}
