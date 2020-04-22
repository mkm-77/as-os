ExitProcess proto 
WriteInt64 PROTO
Crlf PROTO

.data
array QWORD 1,2,3,4,5
theSum QWORD ? 

.code
main PROC
	mov rsi,offset array			; ESI points to array 
	mov rcx,LENGTHOF array			 ; ECX = array count
	call ArraySum					; calculate the sum 
	mov theSum,rax					; returned in EAX 
	call WriteInt64
	
	call Crlf
	mov ecx,0
	call  ExitProcess
main ENDP

;----------------------------------------------------
; ArraySum 
; Calculates the sum of an array of 32-bit integers. 
; Receives: ESI = the array offset 
; ECX = number of elements in the array 
; Returns: EAX = sum of the array elements 
;----------------------------------------------------

ArraySum PROC
	push  rsi			 			; save ESI, ECX 
	push  rcx
	mov   rax,0 					; set the sum to zero
L1:
	add   rax,[rsi]					; add each integer to sum 
	add   rsi,TYPE QWORD 			; point to next integer 
	loop  L1 						; repeat for array size
	
	pop   rcx 						; restore ECX, ESI 
	pop   rsi 
	ret 							; sum is in EAX 
ArraySum ENDP 
	
PUBLIC main
end