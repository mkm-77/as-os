;ml64 /c Encrypt.asm
;link /subsystem:console Encrypt.obj kernel32.Lib MyLib-64.obj /ENTRY:main /largeaddressaware:no

; Encryption Program (Encrypt.asm)

ExitProcess proto 
WriteInt64 PROTO
WriteString     proto
ReadString    proto
Crlf PROTO

KEY = 239 ; any value between 1-255
BUFMAX = 128 ; maximum buffer size

.data
sPrompt BYTE "Enter the plain text:",0
sEncrypt BYTE "Cipher text: ",0
sDecrypt BYTE "Decrypted: ",0
buffer BYTE BUFMAX+1 DUP(0)
bufSize QWORD ?

.code
main PROC
	call InputTheString ; input the plain text
	call TranslateBuffer ; encrypt the buffer
	mov rdx,OFFSET sEncrypt ; display encrypted message
	call DisplayMessage
	call TranslateBuffer ; decrypt the buffer
	mov rdx,OFFSET sDecrypt ; display decrypted message
	call DisplayMessage
main ENDP
;-----------------------------------------------------
; Prompts user for a plaintext string. Saves the string
; and its length.
; Receives: nothing
; Returns: nothing
;-----------------------------------------------------
InputTheString PROC
	push rcx; save 32-bit registers
	push rdx
	push rax
	mov rdx,OFFSET sPrompt ; display a prompt
	call WriteString
	
	mov rcx,BUFMAX ; maximum character count
	mov rdx,OFFSET buffer ; point to the buffer
	call ReadString ; input the string
	mov bufSize,rax ; save the length
	call Crlf
	
	pop  rax
	pop  rdx
	pop  rcx
	ret
InputTheString ENDP
;-----------------------------------------------------
; Displays the encrypted or decrypted message.
; Receives: EDX points to the message
; Returns: nothing
;-----------------------------------------------------
DisplayMessage PROC
	
	push rdx
	call WriteString
	mov rdx,OFFSET buffer ; display the buffer
	call WriteString
	call Crlf
	call Crlf
	
	pop rdx
	ret
DisplayMessage ENDP
;-----------------------------------------------------
; Translates the string by exclusive-ORing each
; byte with the encryption key byte.
; Receives: nothing
; Returns: nothing
;-----------------------------------------------------
TranslateBuffer PROC	
	push  rsi			 		
	push  rcx
	mov rcx,bufSize ; loop counter
	mov rsi,0 ; index 0 in buffer
L1:
	xor buffer[rsi],KEY ; translate a byte
	inc rsi ; point to next byte
	loop L1
	
	pop   rcx 						
	pop   rsi 
	ret
	TranslateBuffer ENDP
PUBLIC main	
END 
