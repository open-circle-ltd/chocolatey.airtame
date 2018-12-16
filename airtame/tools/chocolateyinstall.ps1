# airtame install

$ErrorActionPreference = 'Stop';

$toolsDir            = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$PackageParameters   = Get-PackageParameters
$urlPackage          = 'https://downloads-cdn.airtame.com/application/ga/win_x86/releases/airtame-application-3.3.2-setup.msi'
$checksumPackage     = '0fd35fda8d0033d06d069849324b2ce61af7892b063c4a5f72bce20ff0cfd1f61aac0b15efb705feb88e430f4f30e2e34305d0ea705a1b86c8655fcbc3698a07'
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
