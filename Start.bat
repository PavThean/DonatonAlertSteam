@echo off
chcp 65001 >nul
title PavThean StreamAlert
color 0A

echo.
echo  ________  ________  ___      ___ ________  ___  ___  _______   ________  ________ [cite: 1]
echo ^|\   __  \^|\   __  \^|\  \    /  /^|\__    _\^|\  \^|\  \^|\  ___ \ ^|\   __  \^|\   ___  \ [cite: 1]
echo \ \  \^|\  \ \  \^|\  \ \  \  /  / \^|___ \  \_\ \  \\\\  \ \   __/^|\ \  \^|\  \ \  \\\ \  \ [cite: 1, 2]
echo  \ \   ____\ \   __  \ \  \/  / /     \ \  \ \ \   __  \ \  \_^|/_\ \   __  \ \  \\\ \  \ [cite: 2]
echo   \ \  \_^|__\ \  \ \  \ \    / /       \ \  \ \ \  \ \  \ \  \_^|\ \ \  \ \  \ \  \\\ \  \ [cite: 3]
echo    \ \__\    \ \__\ \__\ \__/ /         \ \__\ \ \__\ \__\ \_______\ \__\ \__\ \__\\\ \__\ [cite: 3]
echo     \^|__^|    \^|__\^|__\^|/           \^|__^|  \^|__^|\^|__\^|_______\^|__^|\^|__\^|__\^| \^|__^| [cite: 4]
echo.
echo  ================================================================ [cite: 5]
echo     ABA Donation Stream Alert  ^|  Powered by PAV THEAN [cite: 5]
echo  ================================================================ [cite: 5]
echo.

:: Check Node.js
node -v >nul 2>&1 [cite: 6]
if errorlevel 1 ( [cite: 6]
    echo  [ERROR] Node.js not found! [cite: 6]
    echo  Please install from: https://nodejs.org [cite: 6]
    echo. [cite: 6]
    pause [cite: 6]
    exit /b 1 [cite: 6]
)

:: Auto npm install / verify dependencies before moving forward
echo  Checking and installing project dependencies...
call npm install
if errorlevel 1 (
    echo  [ERROR] npm install failed. Please check your internet connection.
    pause
    exit /b 1
)
echo  [OK] Dependencies are up to date!
echo.

:: Check if already configured
if exist telegram.config.json ( [cite: 6]
    echo  [INFO] Config found. Skipping setup. [cite: 6]
    goto :run [cite: 6]
)

echo  Fill in the details below to get started. [cite: 6]
echo  ---------------------------------------------------------------- [cite: 7]
echo.

:: LICENSE KEY
:askLicense
set /p LICENSE_KEY= Enter your License Key (PT-...):  [cite: 7]
if "%LICENSE_KEY%"=="" ( [cite: 7]
    echo  [ERROR] License key cannot be empty. [cite: 7]
    goto :askLicense [cite: 7]
)

echo.
echo  Validating license key... [cite: 8]

set MACHINE_ID=%COMPUTERNAME%_%USERNAME% [cite: 8]

powershell -Command "$body = '{\"licenseKey\":\"%LICENSE_KEY%\",\"machineId\":\"%MACHINE_ID%\"}'; try { $r = Invoke-RestMethod -Uri 'https://pt-license-production.up.railway.app/api/validate' -Method POST -ContentType 'application/json' -Body $body; if ($r.valid) { Write-Host '  [OK] License valid. Welcome, ' + $r.owner } else { Write-Host '  [FAIL] ' + $r.reason; exit 1 } } catch { Write-Host '  [ERROR] Cannot reach license server.'; exit 1 }" [cite: 8]

if errorlevel 1 ( [cite: 8]
    echo. [cite: 8]
    echo  Please check your license key and try again. [cite: 8]
    echo. [cite: 8]
    goto :askLicense [cite: 8]
)

echo.
echo  ---------------------------------------------------------------- [cite: 9]
echo  Telegram API Setup [cite: 9]
echo  Get credentials from: https://my.telegram.org/apps [cite: 9]
echo  ---------------------------------------------------------------- [cite: 9]
echo.

:askApiId
set /p TG_API_ID= Enter api_id (numbers only):  [cite: 10]
if "%TG_API_ID%"=="" goto :askApiId [cite: 10]
echo %TG_API_ID%| findstr /r "^[0-9][0-9]*$" >nul [cite: 10, 11]
if errorlevel 1 ( [cite: 11]
    echo  [ERROR] api_id must be numbers only. [cite: 11]
    goto :askApiId [cite: 11]
)

:askApiHash
set /p TG_API_HASH= Enter api_hash:  [cite: 11]
if "%TG_API_HASH%"=="" goto :askApiHash [cite: 11]

echo.
echo  Saving config... [cite: 12]

powershell -Command "$cfg = @{ apiId = %TG_API_ID%; apiHash = '%TG_API_HASH%'; session = '' }; $cfg | ConvertTo-Json | Set-Content -Encoding UTF8 'telegram.config.json'" [cite: 12]

:: Save license key file
echo %LICENSE_KEY%> license.key [cite: 12]

if errorlevel 1 ( [cite: 12]
    echo  [ERROR] Failed to save config. [cite: 12]
    pause [cite: 12]
    exit /b 1 [cite: 12]
)

echo  [OK] Config saved! [cite: 12]
echo.

echo  ================================================================
echo     Setup complete! Starting...
echo  ================================================================
echo.

:run
call npm run start [cite: 14]
pause [cite: 14]
