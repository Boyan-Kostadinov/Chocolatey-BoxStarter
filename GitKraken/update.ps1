param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://www.gitkraken.com/download'
    $url = 'https://release.gitkraken.com/win64/GitKrakenSetup.exe'
    $versionRegEx = 'Latest release: ([0-9\.]+)'

    $releasePage = Invoke-WebRequest -UseBasicParsing -Uri $releaseUrl
    $version = [regex]::match($releasePage.Content, $versionRegEx).Groups[1].Value

    if ($force) {
        $global:au_Version = $release.Version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')