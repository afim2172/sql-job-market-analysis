@echo off
echo ==========================================
echo      AUTO-COMMIT SCRIPT FOR GITHUB
echo ==========================================

:: 1. Check status
echo [1/4] Checking status...
git status
echo.

:: 2. Add all files
echo [2/4] Adding files...
git add .
echo.

:: 3. Commit with timestamp
echo [3/4] Committing...
:: Get a simple timestamp that works on most Windows locales
set "mydate=%date%"
set "mytime=%time%"
git commit -m "Auto-save: %mydate% %mytime%"
echo.

:: 4. Push to GitHub
echo [4/4] Pushing to origin master...
git push origin master
echo.

echo ==========================================
echo      DONE! (Or check errors above)
echo ==========================================
pause
