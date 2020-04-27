;ml64 /c Twodimarray.asm
;link /subsystem:console Twodimarray.obj kernel32.Lib MyLib-64.obj /ENTRY:main /largeaddressaware:no


Crlf proto 
WriteInt64 proto 
ExitProcess proto 

.data 
table QWORD 1, 2, 3, 4, 5 
RowSize = ($ - table) 
	QWORD 6, 7, 8, 9, 10 
	QWORD 11, 12, 13, 14, 15 

	.code
main PROC
	mov rax,1
	mov rsi,4 
	call get_tableVal 
	call WriteInt64 
	call Crlf 
	mov   ecx,0 ; end program 
	call  ExitProcess 
main ENDP

get_tableVal PROC USES rbx 
	mov rbx,RowSize 
	mul rbx ; product(low) = RAX 
	mov rax,table[rax + rsi*TYPE table] 
	ret 
	get_tableVal ENDP 
END