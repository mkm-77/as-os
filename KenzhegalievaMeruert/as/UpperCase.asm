;ml64 /c UpperCase.asm
;link /subsystem:console UpperCase.obj kernel32.Lib MyLib-64.obj /ENTRY:main /largeaddressaware:no

; Converting Characters to Upper case program (UpperCase.asm)

ExitProcess proto 
WriteInt64 PROTO
WriteString     proto
ReadString    proto
Crlf PROTO


BUFMAX = 128 						; maximum buffer size

.data
msg BYTE "Enter the text:",0
array BYTE 50 DUP(?)
buffer BYTE BUFMAX+1 DUP(0)
bufSize QWORD ?

.code
main PROC
	mov rdx,OFFSET msg ; 
	call WriteString
	
	mov rcx,BUFMAX 					; maximum character count
	mov rdx,OFFSET buffer 			; point to the buffer
	call ReadString 				; input the string
	mov bufSize,rax 				; save the length
	call Crlf


	mov rcx,LENGTHOF buffer
	mov rsi,OFFSET buffer
L1: 
	and BYTE PTR [rsi],11011111b 	; clear bit 5
	inc rsi
	loop L1
	
	call WriteString
	mov rdx,OFFSET buffer 			; display the buffer
	call Crlf
	
main ENDP
END
