# airtame install

$ErrorActionPreference = 'Stop';

$toolsDir            = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$PackageParameters   = Get-PackageParameters
$urlPackage = "https://downloads-cdn.airtame.com/app/latest/win/Airtame-4.1.1-setup.msi"
$checksumPackage = "4851c352fac01959a7622e6fa3e70b3f6fb280840a15fca1f40205591c50a0d3714dbf8b514d05e26ce304f81688ce9419da9c23d8d95ea5416afd7af1b943f8"
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
