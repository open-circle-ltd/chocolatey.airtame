# itigo.airtame install

# Globale Settings
$ErrorActionPreference = 'Stop';
$PackageParameters = Get-PackageParameters

if (!$PackageParameters['AUTOSTART']) {
  $PackageParameters['AUTOSTART'] = 'false'
}
Write-Output "Autostart is $($PackageParameters['AUTOSTART'])"

# Package Arguments
$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'MSI'
  url            = 'http://downloads.airtame.com/application/ga/win_x86/releases/airtame-application-3.2.2-setup.msi'
  checksum       = '3DA98328F616E750D029076F6C1C1BC207C664ED3E8D2CBDC6987FCDED9E4126'
  checksumType   = 'sha256'
  checksum64     = ''
  checksumType64 = ''
  silentArgs     = "/quiet WRAPPED_ARGUMENTS=/autostart='$($PackageParameters['AUTOSTART'])'"
}

Install-ChocolateyPackage @packageArgs

# Custome Settings from Package
if (Get-Item -Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Airtame" -ErrorAction SilentlyContinue) {
    Remove-Item `
        -Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Airtame" `
        -Recurse
    Write-Output `
        -InputObject "Remove C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Airtame"
}
if (Get-Item -Path "C:\Users\$($env:UserName)\Desktop\Airtame.lnk" -ErrorAction SilentlyContinue) {
    Remove-Item `
        -Path "C:\Users\$($env:UserName)\Desktop\Airtame.lnk" `
        -Recurse
    Write-Output `
        -InputObject "Remove Shortcut C:\Users\$($env:UserName)\Desktop\Airtame.lnk"
}

Install-ChocolateyShortcut `
  -ShortcutFilePath "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Airtame.lnk" `
  -TargetPath "C:\Program Files (x86)\Airtame\airtame-application.exe" `
  -WorkDirectory "C:\Program Files (x86)\Airtame"
