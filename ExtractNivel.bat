rem LKB 2014 (C)
rem extract data from Nivel 220 using port snipping log files

@ECHO OFF

md SS

rem first cut headers
FOR /f %%F IN ('dir /b *.log') DO (
grep "SUCCESS  Length 35:" %%F | tr -s ' ' | cut -d" " -f1,2,7-9 | cut -d. -f1-4 | tr -s ' ' ',' > %%~nF.csv
)

mv *.log ./SS

pause
