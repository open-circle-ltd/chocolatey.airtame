# airtame install

$ErrorActionPreference = 'Stop';

$toolsDir            = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$PackageParameters   = Get-PackageParameters
$urlPackage = "https://downloads-cdn.airtame.com/app/latest/win/Airtame-4.1.0-setup.msi"
$checksumPackage = "463f641ed16a29cc053d270cc258dc448ea29d49d68605940254374361249986bf3bbbed75000a6a8f4bc7bf0bcc3f618bad689f462cde085cd613f1cb3a1221"
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
