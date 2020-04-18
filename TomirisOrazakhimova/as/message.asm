;ml64  message.asm /link /subsystem:console message.obj /ENTRY:main /largeaddressaware:no

; Sample x64 Assembly Program
; Chris Lomont 2009 www.lomont.org

include include\invoke_macros.asm	
includelib lib\kernel32.lib
includelib lib\user32.lib

extrn ExitProcess: PROC   ; external functions in system libraries
extrn MessageBoxA: PROC
.data
caption db '64-bit hello!', 0
message db 'Hello World!', 0
.code
main PROC
  nvk MessageBoxA, 0,ADDR message,ADDR caption, 0
  mov    ecx, eax     ; uExitCode = MessageBox(...)
  call ExitProcess
main ENDP
End
