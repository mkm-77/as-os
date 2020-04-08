;ml64 /c ArrayScan.asm
;link /subsystem:console ArrayScan.obj kernel32.Lib MyLib-64.obj /ENTRY:main /largeaddressaware:no

; Scanning an Array (ArrayScan.asm)
; Scan an array for the first nonzero value.

ExitProcess 	proto
WriteInt64		proto
WriteString     proto
Crlf 			proto

.data
intArray SQWORD 0,0,0,0,1,20,35,-12,66,4,0
;intArray SQWORD 1,0,0,0 ; alternate test data
;intArray SQWORD 0,0,0,0 ; alternate test data
;intArray SQWORD 0,0,0,1 ; alternate test data
noneMsg BYTE "A non-zero value was not found",0

.code
main PROC
	mov rbx,OFFSET intArray					 ; point to the array
	mov rcx,LENGTHOF intArray 				 ; loop counter
L1: 
	cmp WORD PTR [rbx],0 					 ; compare value to zero
	jnz found 								 ; found a value
	add rbx, TYPE rbx 								 ; point to next
	loop L1 								 ; continue the loop
	jmp notFound 							 ; none found
found: 										 ; display the value
	movsx rax,WORD PTR[rbx]     	 		 ; sign-extend into RAX
	call WriteInt64
	jmp quit
notFound: 									 ; display "not found" message
	mov rdx,OFFSET noneMsg
	call WriteString
quit:
	call Crlf
main ENDP
END