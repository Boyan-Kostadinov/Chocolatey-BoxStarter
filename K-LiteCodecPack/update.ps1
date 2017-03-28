Import-Module AU

$releasesUrl = 'http://codecguide.com/download_k-lite_codec_pack_mega.htm'
$downloadUrl = 'http://files2.codecguide.com/K-Lite_Codec_Pack_$($fileVersion)_Mega.exe'
$versionRegEx = '.*Version ([0-9\.]+) Mega'
$checksumRegEx = '.*<strong>SHA256<\/strong>: ([a-z0-9]+)'

function global:au_SearchReplace {
  return @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
      "(?i)(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_GetLatest {
  $html = Invoke-WebRequest -UseBasicParsing -Uri $releasesUrl

  $version = [regex]::match($html.Content, $versionRegEx).Groups[1].Value
  $Latest.checksum = [regex]::match($html.Content, $checksumRegEx).Groups[1].Value
  
  $fileVersion = $version -replace '\.', ''
  $versiondownloadUrl = $ExecutionContext.InvokeCommand.ExpandString($downloadUrl)
  
  return @{ Url32 = $versiondownloadUrl; Version = $version }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion