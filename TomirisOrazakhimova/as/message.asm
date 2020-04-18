;ml64 /c message.asm /link /subsystem:console message.obj MyLib-64.obj /ENTRY:main /largeaddressaware:no

; Sample x64 Assembly Program
; Chris Lomont 2009 www.lomont.org

include include\invoke_macros.asm
includelib lib\kernel32.lib
includelib lib\user32.lib
includelib lib\Gdi32.lib

extrn ExitProcess: PROC   ; external functions in system libraries
extrn MessageBoxA: PROC
.data
caption db '64-bit hello!', 0
message db 'Hello World!', 0
.code
Start PROC
  nvk MessageBoxA, 0, message, caption, 0
  mov    ecx, eax     ; uExitCode = MessageBox(...)
  call ExitProcess
Start ENDP
End