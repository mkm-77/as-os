@echo off
setlocal
:PROMPT
SET /P CFL=Change file name (y/n)?
IF /I "%CFL%" NEQ "y" GOTO END
ren "test.bat" "almas.bat"
:END
endlocal