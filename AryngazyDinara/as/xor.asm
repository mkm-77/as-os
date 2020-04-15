;ml64 /c XOR.asm
;link /subsystem:console xor.obj kernel32.Lib MyLib-64.obj /ENTRY:main /largeaddressaware:no
; xor simple code

ExitProcess proto 
WriteInt64 PROTO
WriteString     proto
ReadString    proto
Crlf PROTO

KEY = 123 
BUFMAX = 128 

.data
sText BYTE "Enter the text:",0
sEncrypt BYTE "Encrypt text: ",0
sDecrypt BYTE "Decrypted: ",0
buffer BYTE BUFMAX+1 DUP(0)
bufSize QWORD ?

.code
main PROC
	call InputTheString 
	call TranslateBuffer 
	mov rdx,OFFSET sEncrypt 
	call DisplayMessage
	call TranslateBuffer 
	mov rdx,OFFSET sDecrypt 
	call DisplayMessage
main ENDP

InputTheString PROC
	push rcx; save 32-bit registers
	push rdx
	push rax
	mov rdx,OFFSET sPrompt 
	call WriteString
	
	mov rcx,BUFMAX 
	mov rdx,OFFSET buffer 
	call ReadString 
	mov bufSize,rax 
	call Crlf
	
	pop  rax
	pop  rdx
	pop  rcx
	ret
InputTheString ENDP

DisplayMessage PROC
	
	push rdx
	call WriteString
	mov rdx,OFFSET buffer 
	call WriteString
	call Crlf
	call Crlf
	
	pop rdx
	ret
DisplayMessage ENDP

TranslateBuffer PROC	
	push  rsi			 		
	push  rcx
	mov rcx,bufSize 
	mov rsi,0 
L1:
	xor buffer[rsi],KEY 
	inc rsi 
	loop L1
	
	pop   rcx 						
	pop   rsi 
	ret
	TranslateBuffer ENDP
PUBLIC main	
END 