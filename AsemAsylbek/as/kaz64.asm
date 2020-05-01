;ml64 /c kaz64.asm
;link /subsystem:console kaz64.obj MyLib-64.obj /ENTRY:main /largeaddressaware:no

;ml64 kaz64.asm /link /subsystem:console kaz64.obj /ENTRY:main /largeaddressaware:no

include include\invoke_macros.asm
includelib lib\kernel32.lib
includelib lib\user32.lib
includelib lib\Gdi32.lib
includelib lib\gdiplus.lib

MultiByteToWideChar proto
MessageBoxW proto
ExitProcess 	proto
GetStdHandle proto
SetConsoleOutputCP proto
WriteConsoleW proto
WriteConsoleA proto

.const 
	CP_UTF8 equ 65001
	STD_INPUT_HANDLE equ -10
	STD_OUTPUT_HANDLE equ -11
.data
	str_kaz db "Сәлем, Әлем және Әсем!",0
	buf db 128 dup(0)
	clrfstr byte 0dh, 0ah
	consoleInHandle QWORD ?
	consoleOutHandle QWORD ?
.code
main PROC
	nvk MultiByteToWideChar, CP_UTF8,0, addr str_kaz, lengthof str_kaz, addr buf, lengthof str_kaz
	nvk MessageBoxW, 0, addr buf, addr buf, 0
	nvk GetStdHandle, STD_OUTPUT_HANDLE
	mov consoleOutHandle, rax
	nvk WriteConsoleW, consoleOutHandle, addr buf, lengthof str_kaz, 0,0
	nvk WriteConsoleA, consoleOutHandle, addr clrfstr, lengthof clrfstr,0,0
	nvk ExitProcess, 0
main ENDP
end	
 	
  
