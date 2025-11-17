@echo off
echo ======================================
echo   crimsyndata Dataset Export Tool
echo ======================================
echo.
echo This script will export all datasets to CSV and Excel formats.
echo Make sure you have the crimsyndata package installed and openxlsx package.
echo.
pause
echo.
echo Installing required packages...
Rscript -e "if (!require('openxlsx', quietly=TRUE)) install.packages('openxlsx', repos='https://cran.r-project.org')"
echo.
echo Running export script...
Rscript export_datasets.R
echo.
echo Export completed! Check the 'exports' folder for your files.
echo.
pause