@echo off

SET PRIORITY=/NORMAL

SET /A HIDDEN=1

SET ARGS=/I %PRIORITY%
SET ARGS2=^<%1^>%2

IF %HIDDEN% EQU 1 SET ARGS=%ARGS% /B
IF %HIDDEN% EQU 2 SET ARGS=%ARGS% /MIN

a.exe %ARGS2% 

SET ErrOut=%ERRORLEVEL%
IF %ERRORLEVEL% EQU -1073741819 SET ErrOut=%ERRORLEVEL% [ OUT OF BOUNDS ERROR ? ]
IF %ERRORLEVEL% EQU -1073741676 SET ErrOut=%ERRORLEVEL% [ DIVISION BY ZERO ? ]

IF %ERRORLEVEL% NEQ 0 ECHO RUNTIME ERROR & ECHO.Process Terminated with exit code %ErrOut%
exit /b

rem rem :RUN_DONE
rem rem @echo %errorlevel%
rem rem @echo %result%
