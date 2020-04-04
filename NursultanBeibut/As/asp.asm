;ml64 /c NumberEven.asm
;link /subsystem:console NumberEven.obj kernel32.Lib MyLib-64.obj /ENTRY:main /largeaddressaware:no
; Program for determining even numbers in an array

ExitProcess 	proto
WriteInt64		proto
WriteString     proto
Crlf 			proto


.data
intArray  QWORD  2,3,4,5,6,7,8,9,10
Message BYTE "A even number is not",0
 
.code 
main PROC
	mov rbx,OFFSET intArray				; directing it to the array
	mov rcx,LENGTHOF intArray 			; loop counter	
L1:
	mov ah,0   					
    mov al,[rbx] 
	mov dh,2
    idiv dh
    cmp ah,0
	je found								
	add   rbx,TYPE rbx							
	loop  L1 									
	jmp   notFound 								
found: 	     									
	movsx rax,WORD PTR[rbx] 					
	call  WriteInt64
	add rbx,TYPE rbx                             
	Loop L1	
	jmp  quit
notFound: 										
	mov rdx,OFFSET Message
	call WriteString 
quit:
	call Crlf 
	call  ExitProcess
	
main endp
PUBLIC main
end
