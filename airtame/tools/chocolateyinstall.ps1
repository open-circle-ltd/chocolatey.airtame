# airtame install

$ErrorActionPreference = 'Stop';

$toolsDir            = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$PackageParameters   = Get-PackageParameters
$urlPackage          = 'https://downloads-cdn.airtame.com/application/ga/win_x86/releases/airtame-application-3.3.1-setup.msi'
$checksumPackage     = '5ca379353e97a24dc527ec20e405f2f1ba14480539334fbd686a2ccde6bacd1252f2ff10dcff5b3eb14271b83942d0c571aa1c2681c1669c1f57c6b58a8a9a7e'
$checksumTypePackage = 'SHA512'

Import-Module -Name "$($toolsDir)\helpers.ps1"

if (!$PackageParameters['Autostart']) {
    $PackageParameters['Autostart'] = 'false'
}
Write-Output "Autostart is $($PackageParameters['Autostart'])"

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    fileType       = 'MSI'
    url            = $urlPackage
    checksum       = $checksumPackage
    checksumType   = $checksumTypePackage
    silentArgs     = "/quiet WRAPPED_ARGUMENTS=/autostart='$($PackageParameters['AUTOSTART'])'"
}

Install-ChocolateyPackage @packageArgs

if ($PackageParameters.RemoveDesktopIcons) {
    Remove-DesktopIcons -Name "Airtame" -Desktop "All"
}

if ($PackageParameters.CleanStartmenu) {
	Remove-FileItem `
		-Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Airtame\"
    Install-ChocolateyShortcut `
        -ShortcutFilePath "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Airtame.lnk" `
        -TargetPath "C:\Program Files (x86)\Airtame\airtame-application.exe" `
        -WorkDirectory "C:\Program Files (x86)\Airtame"
}	
