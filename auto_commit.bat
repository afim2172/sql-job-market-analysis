@echo off
set "timestamp=%date:/=-%_%time::=-%"
set "timestamp=%timestamp: =%"
echo Updating repository...

git add .
git commit -m "Auto-save: %timestamp%"
git push origin master

echo Done! Check GitHub for updates.
pause
