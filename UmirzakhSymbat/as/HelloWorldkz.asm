;ml64 /c HelloWorldKZ.asm
;link /subsystem:console HelloWorldKZ.obj MyLib-64.obj /ENTRY:main /largeaddressaware:no

;ml64 HelloWorldKZ.asm /link /subsystem:console HelloWorldKZ.obj /ENTRY:main /largeaddressaware:no

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
	string_kz db "Сәлем,Әлем!",0
        string_en db "English text",0
	buf db 128 dup(0)
	clrfstr byte 0dh, 0ah
	consoleInHandle QWORD ?
	consoleOutHandle QWORD ?
  
  
.code
main PROC

	nvk MultiByteToWideChar, CP_UTF8,0, addr string_kz, lengthof string_kz, addr buf, lengthof string_kz
	nvk MessageBoxW, 0, addr buf, addr buf, 0
	nvk GetStdHandle, STD_OUTPUT_HANDLE
	mov consoleOutHandle, rax
	nvk WriteConsoleW, consoleOutHandle, addr buf, lengthof string_kz, 0,0
	nvk WriteConsoleA, consoleOutHandle, addr clrfstr, lengthof clrfstr,0,0
        nvk WriteConsoleA, consoleOutHandle, addr string_en , lengthof string_en, 0,0
	nvk ExitProcess, 0

main ENDP
end	
 	
