;ml64 /c RegisterLetters.asm
;link /subsystem:console RegisterLetters.obj kernel32.Lib MyLib-64.obj /ENTRY:main /largeaddressaware:no



ExitProcess proto 
WriteInt64 PROTO
WriteString     proto
ReadString    proto
Crlf PROTO


BUFMAX = 128 						
size

.data
msg BYTE "Text:",0
array BYTE 50 DUP(?)
buffer BYTE BUFMAX+1 DUP(0)
bufSize QWORD ?

.code
main PROC
	mov rdx,OFFSET msg 
	call WriteString
	
	mov rcx,BUFMAX 					
count
	mov rdx,OFFSET buffer 			
buffer
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
buffer
	call Crlf
	
main ENDP
END
