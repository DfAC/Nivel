rem LKB 2014-17 (c)
rem extract data from Nivel 220 using port snipping log files

@ECHO OFF

md SS

rem first cut headers
FOR /f %%F IN ('dir /b *.LOG') DO (
grep "C1N1 X" %%F | tr -s ' ' | cut -f2,7-9 | cut -d. -f1-7 | tr -s '\t :' ',' | cut -d"," -f1,8,10,12 | tr '+' ' ' > %%~nF.csv
)

mv *.log ./SS

pause