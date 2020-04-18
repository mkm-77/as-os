;ml64 /c MessageBox.asm
;link /subsystem:console MessageBox.obj kernel32.Lib /ENTRY:main /largeaddressaware:no

;ml64 MessageBox.asm /link /subsystem:console MessageBox.obj /ENTRY:main /largeaddressaware:no

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
main PROC
  nvk MessageBoxA, 0, ADDR message, ADDR caption, 0
  mov    rcx, rax     ; uExitCode = MessageBox(...)
  call ExitProcess
main ENDP
End