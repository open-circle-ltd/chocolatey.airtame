import-module au

$url                 = 'https://help.airtame.com/general/product-changes'
$checksumTypePackage = "SHA512"

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1'   = @{
            "(^\s*[$]*urlPackage\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^\s*[$]*checksumPackage\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^\s*[$]*checksumTypePackage\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }; 
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $url -UseBasicParsing -DisableKeepAlive

    $reLatestbuild = '(.*">App v.*)'
    $download_page.RawContent -imatch $reLatestbuild
    $latestbuild = $Matches[0]

    $reVersion = "(\d+)(.)(\d+)(.)(\d+)"
    $latestbuild -imatch $reVersion
    $version = $Matches[0]
  
    $urlPackage = "https://downloads-cdn.airtame.com/application/ga/win_x86/releases/airtame-application-$($version)-setup.msi"

    return @{
        URL32          = $urlPackage;
        ChecksumType32 = $checksumTypePackage;
        Version        = $version
    }
}

function global:au_AfterUpdate ($Package) {
    Set-DescriptionFromReadme $Package -SkipFirst 3
}
update
