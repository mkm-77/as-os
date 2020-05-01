
;ml64 /c Helloworld64.asm /link /subsystem:console 

	
	include include\invoke_macros.asm
	includelib lib\kernel32.lib
	includelib lib\user32.lib
	includelib lib\Gdi32.lib
	includelib lib\gdiplus.lib
	
	ExitProcess proto : Dword
	MultiByteToWideChar proto :dword, :dword, :ptr, :dword, :ptr, :dword
	MessageBoxW proto :ptr, :ptr, :ptr, :dword
	GetStdHandle proto :dword
	SetConsoleOutputCP proto :dword
	WriteConsoleW proto :ptr, :ptr, :dword, :ptr, :ptr 
	WriteConsoleA proto :ptr, :ptr, :dword, :ptr, :ptr
	
	.const 
		CP_UTF8 equ 65001
		STD_INPUT_HANDLE equ -10
		STD_OUTPUT_HANDLE equ -11
	.data
		str_kaz db "Cәлем әлем!",0
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
	 	
	
