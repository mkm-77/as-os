;ml64 /c evennumber.asm
;link /subsystem:console evennumber.obj kernel32.Lib MyLib-64.obj /ENTRY:main /largeaddressaware:no

ExitProcess 	proto
WriteInt64		proto
WriteString     proto
Crlf 			proto


.data
intArray  QWORD  10,11,12,13,14,15,16,17,18,19,20
Message BYTE "Even number was not found",0
 
.code 
main PROC
	mov   rbx,OFFSET intArray						
	mov   rcx,LENGTHOF intArray 					
L1:
	mov   ah,0   									
    mov   al,[rbx] 
	mov   dh,2
    idiv  dh
    cmp   ah,0
	je    found								
	add   rbx,TYPE rbx						
	loop  L1 									
	jmp   notFound 								
found: 	     									
	movsx rax,WORD PTR[rbx] 					
	call  WriteInt64
	add   rbx,TYPE rbx                           
	Loop  L1	
	jmp   quit
notFound: 										
	mov   rdx,OFFSET Message
	call  WriteString 
quit:
	call  Crlf 
	call  ExitProcess
	
main endp
PUBLIC main
end