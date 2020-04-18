;ml64 /c mult.asm /link /subsystem:console mult.obj MyLib-64.obj /ENTRY:main /largeaddressaware:no

;ml64 /c mult.asm
;link /subsystem:console mult.obj kernel32.Lib MyLib-64.obj /ENTRY:main /largeaddressaware:no
 
;Multiply an Array (Mult.asm)
; This program multiplies each element of an array
; of 64-bit integers by a constant value.

includelib lib\kernel32.lib
includelib lib\user32.lib


ExitProcess PROTO
WriteInt64 PROTO
Crlf PROTO

.data
array QWORD 1,2,3,4,5,6,7,8,9,10 			; test data
multiplier QWORD 10 					; test data

.code
main PROC
	cld 						; direction = forward
	mov rsi,OFFSET array 				; source index
	mov rdi,rsi 					; destination index
	mov rcx,LENGTHOF array 				; loop counter
L1: 
	lodsd 						; load [ESI] into EAX
	mul multiplier 					; multiply by a value
	stosd 						; store EAX into [EDI]
	call WriteInt64
	call Crlf
	loop L1
	
	call ExitProcess
main ENDP
END
