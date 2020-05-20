# airtame install

$ErrorActionPreference = 'Stop';

$toolsDir            = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$PackageParameters   = Get-PackageParameters
$urlPackage = "https://downloads-cdn.airtame.com/app/latest/win/Airtame-4.0.1-setup.msi"
$checksumPackage = "ba06ef5db64756c960ecd7ac4736fc2419a3eea0bb6ced0c2c7ccc27418c8a3b347edadca3ba76f588c1cd2f8be273e377928cfcb311ae1f014e964256f7d106"
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
