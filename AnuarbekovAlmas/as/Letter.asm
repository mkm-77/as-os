;ml64 /c letter.asm
;link /subsystem:console letter.obj kernel32.Lib MyLib-64.obj /ENTRY:main /largeaddressaware:no

; Converting Characters to Upper case program (UpperCase.asm)

ExitProcess   proto 
WriteInt64    PROTO
WriteString   proto
ReadString    proto
Crlf          PROTO


BUFMAX = 128 						

.data
msg     BYTE "Enter the letter:",0
array   BYTE 50 DUP(?)
buffer  BYTE BUFMAX+1 DUP(0)
bufSize QWORD ?

.code
main PROC
	mov  rdx,OFFSET msg ; 
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
	
main ENDP
END