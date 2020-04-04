;ml64 /c Upper.asm
;link /subsystem:console Upper.obj kernel32.Lib MyLib-64.obj /ENTRY:main /largeaddressaware:no

ExitProcess     proto 
WriteInt64      proto
WriteString     proto
ReadString      proto
Crlf            proto

BUFMAX = 128 						
.data
message BYTE "Enter the text:",0
array BYTE 50 DUP(?)
buffer BYTE BUFMAX+1 DUP(0)
bufSize QWORD ?

.code
main PROC
	
mov rdx,OFFSET message;         
call WriteString

mov rcx,BUFMAX 					
mov rdx,OFFSET buffer 			
call ReadString 				
	
mov bufSize,rax 				
call Crlf


mov rcx,LENGTHOF buffer
mov rsi,OFFSET buffer
L1: 
and BYTE PTR [rsi],11011111b 	
inc rsi
loop L1
	
call WriteString
mov rdx,OFFSET buffer 			
	
call Crlf
call ExitProcess
main ENDP
END
