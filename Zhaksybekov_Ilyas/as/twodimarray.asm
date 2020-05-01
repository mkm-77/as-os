;ml64 /c twodimarray.asm /link /subsystem:console twodimarray.obj MyLib-64.obj /ENTRY:main /largeaddressaware:no

;ml64 /c twodimarray.asm
;link /subsystem:console twodimarray.obj kernel32.Lib MyLib-64.obj /ENTRY:main /largeaddressaware:no

; Two-dimensional arrays in 64-bit mode (twodimarray.asm)

includelib lib\kernel32.lib
includelib lib\user32.lib


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
	mov rax,1 ; row index (zero-based) 
	mov rsi,4 ; column index (zero based) 
	call get_tableVal ; returns the value in RAX 
	call WriteInt64 ; and display it 
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
	end
