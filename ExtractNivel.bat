rem LKB 2014-16 (c)
rem extract data from Nivel 220 using port snipping log files
rem this script looks at Nivel response to catch all responses

@ECHO OFF

md SS

rem first cut headers
FOR /f %%F IN ('dir /b *.log') DO (
grep "C1N1 X" %%F | tr -s ' ' | cut -d" " -f1,2,7-9 | cut -d. -f1-4 | tr -s ' ' ',' > %%~nF.csv
)

mv *.log ./SS

pause
