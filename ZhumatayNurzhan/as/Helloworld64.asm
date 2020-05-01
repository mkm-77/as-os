;ml64 /c helloworld64.asm /link /subsystem:console
;

includelib lib\kernel32.lib
includelib lib\user32.lib
includelib lib\Gdi32.lib
includelib lib\gdiplus.lib

	.686
	.model flat , stdcall

ExitProcess proto :dword
MultiByteToWideChar proto : dword , :ptr, :dword, :ptr, :dword
MessageBoxW proto : ptr, :ptr, :dword
GetStdHandle proto :dword
SetConsoleOutputCP proto :dword
WriteConsoleW proto : :ptr, :ptr, :dword, :ptr , :ptr
WriteConsoleA proto : :ptr, :ptr, :dword, :ptr , :ptr

.const 
	CP_UTF8 equ 65001
	STD_INPUT_HANDLE equ -10
	STD_OUTPUT_HANDLE equ -11
.data
	str_kaz db "�?��� ?���",0
	buf db 128 dup(0)
	clrfstr byte 0dh, 0ah
	consoleInHandle QWORD ?
	consoleOutHandle QWORD ?
.code
main PROC
	invoke MultiByteToWideChar, CP_UTF8,0, addr str_kaz, lengthof str_kaz, addr buf, lengthof str_kaz
	invoke MessageBoxW, 0, addr buf, addr buf, 0
	invoke GetStdHandle, STD_OUTPUT_HANDLE
	mov consoleOutHandle, rax
	invoke WriteConsoleW, consoleOutHandle, addr buf, lengthof str_kaz, 0,0
	invoke WriteConsoleA, consoleOutHandle, addr clrfstr, lengthof clrfstr,0,0
	invoke ExitProcess, 0
main ENDP
end	
