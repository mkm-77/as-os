;ml64 /c messagebox.asm
;link /subsystem:console messagebox.obj kernel32.Lib /ENTRY:main /largeaddressaware:no

;ml64 new.asm /link /subsystem:console messagebox.obj /ENTRY:main /largeaddressaware:no

include include\invoke_macros.asm
includelib lib\kernel32.lib
includelib lib\user32.lib
includelib lib\Gdi32.lib

extrn ExitProcess: PROC       
extrn MessageBoxA: PROC
.data
caption db '64-bit hello!', 0
message db 'Hello World!', 0
.code
main PROC
  nvk MessageBoxA, 0, ADDR message, ADDR caption, 0
  mov    rcx, rax             
  call ExitProcess
main ENDP
End