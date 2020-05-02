;ml64 /c SumOf.asm
;link /subsystem:console SumOf.obj kernel32.Lib MyLib-64.obj /ENTRY:main /largeaddressaware:no


ExitProcess PROTO
WriteInt64 PROTO
Crlf PROTO

.code 
main PROC
	mov rax,5
	mov rbx,2
	mov rcx,7
	call SumOf
	call WriteInt64
	call Crlf
	
	mov ecx,0
	call ExitProcess
main ENDP

SumOf PROC 
	add  rax,rbx    
	add  rax,rcx    
	ret 
SumOf ENDP
END