@echo off
setlocal
:PROMPT
SET /P CFL=Change file name (y/n)?
IF /I "%CFL%" NEQ "y" GOTO END

@set /p NN= "new name-->"
echo %NN%
ren "exam.bat" almas.bat
:END
endlocal