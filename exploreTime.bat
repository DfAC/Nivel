rem LKB(c)
rem USAGE: Import LGO output (TS30), using following naming convention:

@ECHO off

FOR /f %%F IN ('dir /b *.csv') DO (
	gnuplot -e "InFilename='%%F'" "exploreTime.plt"
	)
)
pause