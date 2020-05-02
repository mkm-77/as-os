;ml64 /c InputKZWord.asm
;link /subsystem:console InputKZWord.obj MyLib-64.obj /ENTRY:main /largeaddressaware:no
;ml64 InputKZWord.asm /link /subsystem:console InputKZWord.obj /ENTRY:main /largeaddressaware:no

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
ReadConsoleW proto

.const 
	CP_UTF8 equ 65001
	STD_INPUT_HANDLE equ -10
	STD_OUTPUT_HANDLE equ -11
  
.data
  msg db "Мәтінді енгізіңіз:"
	buf db 128 dup(0)
	clrfstr byte 0dh, 0ah
	consoleInHandle QWORD ?
	consoleOutHandle QWORD ?
  NumberOfCharsRead QWORD ?
  NumberOfCharsWritten QWORD ?	
  
  
.code
main PROC
     nvk AllocConsole			

     nvk GetStdHandle, STD_INPUT_HANDLE	
     mov hConsoleInput, RAX			

     nvk GetStdHandle, STD_OUTPUT_HANDLE	
     mov hConsoleOutput, RAX			
 
     nvk WriteConsoleA,			
     hConsoleOutput,	
     addr msg1310,
    SIZEOF msg1310,	
    addr NumberOfCharsWritten,	
       0	

    nvk WriteConsoleA,			
    hConsoleOutput,
    addr msg1,
    SIZEOF msg1,
    addr NumberOfCharsWritten,
    0
                                   
  nvk WriteConsoleA,		
      hConsoleOutput,
      addr msg1310,
      SIZEOF msg1310,
      addr NumberOfCharsWritten,
       0                           
                                   
   nvk CharToOem, addr msg2, addr msg2	

  nvk ReadConsoleW,			
  hConsoleInput,	
  addr Buffer,	
   1,	
  addr NumberOfCharsRead,	
   0	                                

	nvk ExitProcess, 0

main ENDP
end	
