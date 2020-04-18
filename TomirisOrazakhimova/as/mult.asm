ml64  mult.asm /link /subsystem:console mult.obj MyLib-64.obj /ENTRY:main /largeaddressaware:no

includelib lib\kernel32.lib
includelib lib\user32.lib



Crlf        proto 
WriteInt64  proto 
ExitProcess proto 


.data 
array QWORD 1,2,3,4,5,6,7,8,9,10			; test data 
multiplier QWORD 10						      	; test data 

.code 
main PROC 
	cld  						                    ; direction = forward 
	mov rsi,OFFSET array  	          	; source index 
	mov rdi,rsi 				                ; destination index 
	mov rcx,LENGTHOF array 	          	; loop counter 
L1:
	lodsd                             	; load [ESI] into EAX 
	mul multiplier 				              ; multiply by a value 
	stosd                             	; store EAX into [EDI] 
	call Crlf
	call WriteInt64
	loop L1 
	call ExitProcess
main ENDP 
END 






















