@echo off
setlocal

rem install dir
set BASE=%LOCALAPPDATA%\Echo360Downloader
if not exist "%BASE%" md "%BASE%"

rem copy native bits from repo root
xcopy /Y ".\native_host.py"        "%BASE%\" >nul
xcopy /Y ".\native_host.bat"       "%BASE%\" >nul

rem write manifest JSON
(
  echo {
  echo   "name": "com.echo360_downloader.host",
  echo   "description": "Echo360 Downloader native host",
  echo   "path": "%BASE%\\native_host.bat",
  echo   "type": "stdio",
  echo   "allowed_origins": ["chrome-extension://lhoanpfjgeppmmdoojhddjeajiopfgng/"]
  echo }
) > "%BASE%\com.echo360_downloader.host.json"

rem register in registry
reg add "HKCU\Software\Google\Chrome\NativeMessagingHosts\com.echo360_downloader.host" ^
    /ve /t REG_SZ /d "%BASE%\com.echo360_downloader.host.json" /f

echo.
echo ✅  Native host installed to %BASE%
echo ➡️  Now open chrome://extensions, enable Developer mode, and drag extension.crx in.
pause
