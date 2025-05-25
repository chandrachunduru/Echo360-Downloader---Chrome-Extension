# install.ps1
[CmdletBinding()]
Param()

# 1) Where to put the native host bits
$base = Join-Path $env:LOCALAPPDATA 'Echo360Downloader'
if (-not (Test-Path $base)) {
    New-Item -ItemType Directory -Path $base | Out-Null
}

# 2) Copy the files from your repo root into that folder
Copy-Item -Path '.\native_host.bat'       -Destination $base -Force
Copy-Item -Path '.\native_host.py'        -Destination $base -Force
Copy-Item -Path '.\echo360-ext\com.echo360_downloader.host.json' ` -Destination $base -Force

# 3) Register the native messaging host in the registry
$regPath = 'HKCU:\Software\Google\Chrome\NativeMessagingHosts\com.echo360_downloader.host'
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}
Set-ItemProperty -Path $regPath -Name '(Default)' -Value (Join-Path $base 'com.echo360_downloader.host.json')

Write-Host "✅ Native host installed to $base"
Write-Host "➡️  Now go to chrome://extensions → Load unpacked → select the 'echo360-ext' folder."
