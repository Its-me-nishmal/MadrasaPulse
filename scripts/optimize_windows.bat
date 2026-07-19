@echo off
echo =============================================
echo  MADRASAPULSE - EXTREME SOFTWARE OPTIMIZER
echo =============================================
echo.

echo [1/5] Removing Edge auto-launch from startup...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "MicrosoftEdgeAutoLaunch_5EF70F99B4529735F3564FFE246DB961" /f >nul 2>&1
echo Done.

echo [2/5] Removing Chrome auto-launch from startup...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "GoogleChromeAutoLaunch_332B101ED56858E0765C41199BCD4350" /f >nul 2>&1
echo Done.

echo [3/5] Removing OneDrive from startup...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f >nul 2>&1
echo Done.

echo [4/5] Disabling Windows Search Indexing (saves CPU during builds)...
sc config WSearch start= disabled >nul 2>&1
net stop WSearch >nul 2>&1
echo Done.

echo [5/5] Disabling SysMain (Superfetch) to free up RAM reserved for prediction...
sc config SysMain start= disabled >nul 2>&1
net stop SysMain >nul 2>&1
echo Done.

echo [6/6] Setting CPU minimum processor state to 100%% for max clock speed...
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMIN 100
powercfg /setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMIN 100
powercfg /s SCHEME_CURRENT
echo Done.

echo.
echo =============================================
echo  ALL OPTIMIZATIONS APPLIED SUCCESSFULLY!
echo  Please RESTART your laptop for full effect.
echo =============================================
pause
