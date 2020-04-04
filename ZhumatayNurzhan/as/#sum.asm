; кез келген сандарды қосу программасы
; кез келген 3 санды қосу 

;ml64 /c sumnumber.asm
;link /subsystem:console sumnumber.obj kernel32.Lib MyLib-64.obj /ENTRY:main /largeaddressaware:no


ExitProcess PROTO
WriteInt64 PROTO
Crlf PROTO

.code 
main PROC
	mov rax,3
	mov rbx,4
	mov rcx,5
	call sumnumber
	call WriteInt64
	call Crlf
	
	mov ecx,0
	call ExitProcess
main ENDP

sumnumber PROC 
	add  rax,rbx    
	add  rax,rcx    
	ret 
sumnumber ENDP
END





