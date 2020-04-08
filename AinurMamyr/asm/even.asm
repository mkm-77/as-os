;ml64 /c Even.asm
;link /subsystem:console Even.obj kernel32.Lib MyLib-64.obj /ENTRY:main /largeaddressaware:no

ExitProcess 	proto
WriteInt64		proto
WriteString     proto
Crlf 			proto


.data
intArray  QWORD  5,6,-8,7,-2,0,9,14
Message BYTE "A even value was not found",0
 
.code 
main PROC
	mov rbx,OFFSET intArray						; point to the array
	mov rcx,LENGTHOF intArray 					; loop counter	
L1:
	mov ah,0   									;residue
    mov al,[rbx] 
	mov dh,2
    idiv dh
    cmp ah,0
	je found								
	add   rbx,TYPE rbx							; point to next 
	loop  L1 									; continue the loop 
	jmp   notFound 								; none found 
found: 	     									
	movsx rax,WORD PTR[rbx] 					; sign-extend into EAX 
	call  WriteInt64
	add rbx,TYPE rbx                            ; point to next 
	Loop L1	
	jmp  quit
notFound: 										; display "not found" message
	mov rdx,OFFSET Message
	call WriteString 
quit:
	call Crlf 
	call  ExitProcess
	
main endp
PUBLIC main
end