; Scanning an Array             (AS.asm)
; Scan an array for the first nonzero value.

;ml64 /c MyLib-64.asm
;ml64 /c ArrScan.asm
;link /subsystem:console ArrScan.obj kernel32.Lib MyLib-64.obj /ENTRY:main /largeaddressaware:no

ExitProcess PROTO
WriteInt64 PROTO
WriteString PROTO
Crlf PROTO


 
 .data 
 intArray  QWORD  0,0,0,20,35,-12,66,4,0 
 
;intArray QWORD  1,0,0,0 ; alternate test data 
;intArray QWORD  0,0,0,0
;intArray QWORD  0,0,0,1 
 noneMsg  BYTE "A non-zero value was not found",0
 
 .code 
 main PROC
	mov rbx,OFFSET intArray						
	mov rcx,LENGTHOF intArray 				
	 		
L1:
	cmp   WORD PTR [rbx],0 						
	jnz   found 						
	add   rbx,TYPE rbx						
	loop  L1 							 
	jmp   notFound 						 
found: 								 
	movsx rax,WORD PTR[rbx] 					
	call  WriteInt64 
	jmp   quit
notFound: 										
	mov   rdx,OFFSET noneMsg
	call WriteString 
quit:
	call Crlf 
	
	
call  ExitProcess
main endp
PUBLIC main
end
