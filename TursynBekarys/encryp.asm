; Encryption Program                   

;ml64 /c MyLib-64.asm
;ml64 /c Encrypt.asm
;link /subsystem:console Encrypt.obj kernel32.Lib MyLib-64.obj /ENTRY:main /largeaddressaware:no

ExitProcess 	proto
ReadInt64       proto
ReadString      proto
WriteString		proto
WriteInt64		proto
Crlf 			proto


KEY = 239 ; any value between 1-255 
BUFMAX = 128 ; maximum buffer size

.data 
sPrompt  BYTE "Enter the plain text:",0
sEncrypt BYTE "Cipher text: ",0 
sDecrypt BYTE "Decrypted: ",0 
buffer   BYTE BUFMAX+1 DUP(0) 
bufSize  QWORD ?
.code 
main PROC 
	call InputTheString 		; input the plain text 
	call TranslateBuffer 		; encrypt the buffer 
	mov rdx,OFFSET sEncrypt 	; display encrypted message 
	call DisplayMessage 
	call TranslateBuffer  		; decrypt the buffer 
	mov rdx,OFFSET sDecrypt 	; display decrypted message 
	call DisplayMessage 
	call ExitProcess
 main ENDP

InputTheString PROC 
	push rax					; save 32-bit registers 
	mov rdx,OFFSET sPrompt 		; display a prompt 
	call WriteString 
	mov rcx,BUFMAX				; maximum character count 
	mov rdx,OFFSET buffer   	; point to the buffer 
	call ReadString         	; input the string 
	mov bufSize,rax        		; save the length 
	call Crlf 
	pop rax
	ret
InputTheString ENDP

DisplayMessage PROC
	push rax
	call WriteString 
	mov rdx,OFFSET buffer 		; display the buffer 
	call WriteString 
	call Crlf 
	call Crlf 
	pop rax
	ret 
DisplayMessage ENDP 

TranslateBuffer PROC 
	push rax
	mov rcx,bufSize 			; loop counter 
	mov rsi,0 					; index 0 in buffer
L1:
	xor buffer[rsi],KEY 		; translate a byte 
	inc rsi 					; point to next byte 
	loop L1 
	pop  rax
	ret 
TranslateBuffer ENDP

END 
