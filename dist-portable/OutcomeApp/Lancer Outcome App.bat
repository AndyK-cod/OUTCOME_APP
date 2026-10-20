@echo off
rem ============================================================
rem  Outcome App - Lanceur portable
rem  Double-cliquez sur ce fichier pour demarrer l'application.
rem  NE FERMEZ PAS cette fenetre pendant l'utilisation :
rem  la fermer arrete l'application.
rem ============================================================
setlocal
cd /d "%~dp0"
title Outcome App - Ne pas fermer cette fenetre

set "R_HOME=%~dp0r-win"
set "R_LIBS=%~dp0r-win\library"
set "R_LIBS_USER=%~dp0r-win\library"
set "R_LIBS_SITE=%~dp0r-win\library"
set "RSTUDIO_PANDOC=%~dp0r-win"
set "OUTCOME_MODA_CACHE_DIR=%~dp0cache\moda"

echo Demarrage de l'Outcome App...
echo Le navigateur va s'ouvrir automatiquement.
echo.
echo IMPORTANT : ne fermez pas cette fenetre pendant l'utilisation.
echo.

"%~dp0r-win\bin\Rscript.exe" "app\launch_portable.R"

echo.
echo L'application est arretee. Vous pouvez fermer cette fenetre.
pause
endlocal
