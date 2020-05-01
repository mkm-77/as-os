;ml64 /c SegmentArray.asm
;link /subsystem:console SegmentArray.obj kernel32.Lib MyLib-64.obj /ENTRY:main /largeaddressaware:no


ExitProcess 	proto
WriteInt64		proto
WriteString     proto
Crlf 			proto

.data
intArray SQWORD 0,0,0,0,1,50,15,-1,76,20,5
;intArray SQWORD 1,0,0,0 ; alternate test data
;intArray SQWORD 0,0,0,0 ; alternate test data
;intArray SQWORD 0,0,0,1 ; alternate test data
noneMsg BYTE "A non-zero value was not found",0

.code
main PROC
	mov rbx,OFFSET intArray				
	mov rcx,LENGTHOF intArray 				 
L1: 
	cmp WORD PTR [rbx],0 					 
to zero
	jnz found 								 
value
	add rbx, TYPE rbx 								 ; point to next
	loop L1 								 
	jmp notFound 						
found: 									
	movsx rax,WORD PTR[rbx]     	 		 
into RAX
	call WriteInt64
	jmp quit
notFound: 									 
"not found" message
	mov rdx,OFFSET noneMsg
	call WriteString
quit:
	call Crlf
main ENDP
END
