﻿$ErrorActionPreference  = 'Stop';

$toolsDir               = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url                    = 'https://cdn.stardock.us/downloads/public/software/windowfx/WindowFX_setup_sd.exe'
$checksum               = '73a633761f3248230f74f9681740d92b0cd4a6c68914823c5544447fd3e7c246'
$checksumType           = 'sha256'

$packageArgs = @{
  packageName           = $env:ChocolateyPackageName
  unzipLocation         = $toolsDir
  fileType              = 'exe'
  softwareName          = "Stardock WindowFX*"
  url                   = $url
  checksum              = $checksum
  checksumType          = $checksumType
  silentArgs            = '/s'
  validExitCodes        = @(0)
}

[version]$OSVer = (Get-WmiObject Win32_OperatingSystem).Version
$min='6.0.6002'

If ( $OSVer -lt [version]$min ) {
  Write-Warning "*** Stardock WindowFX requires an OS running Windows Vista or higher... ***`n"
  throw
} Else {
  Install-ChocolateyPackage @packageArgs
}
