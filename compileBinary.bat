rem LKB 2016(c)
rem compile python into exec

@ECHO off

FOR /f %%F IN ('dir /b *.py') DO (
	pyinstaller.exe --onefile --distpath ./ %%F
	)
)
rd /s /q build\
del *.spec

rem pause