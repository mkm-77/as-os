;ml64  /link /subsystem:console Ucase_length.obj MyLib-64.obj /ENTRY:main /largeaddressaware:no


Crlf proto 
WriteInt64 proto 
ExitProcess proto 
WriteString proto
Str_length PROTO

include include\invoke_macros.asm
includelib lib\kernel32.lib
includelib lib\user32.lib


.data 
string_1  BYTE "abcde////",0 
msg1      BYTE "string_1 : ",0
msg2      BYTE "string_1 in upper case: ",0 
msg3      BYTE "Length of string_1 is  ",0

.code
	main PROC 
	mov rdx,OFFSET msg1
	call WriteString 
	mov rdx,OFFSET string_1 
	call WriteString 
	call Crlf 
	
	
	mov rdx,OFFSET msg2 
	call WriteString 
	nvk Str_ucase, ADDR string_1
	mov rdx,OFFSET string_1 
	call WriteString 
	call Crlf 
	
	mov rdx,OFFSET msg3
	call WriteString 
	nvk Str_length, ADDR string_1 
	call WriteInt64
	call Crlf 
	

Str_ucase PROC 
	mov rsi,offset string_1 		
L1:
	mov al,[rsi] 						; get char 
	cmp al,0 							; end of string? 
	je L3 								; yes: quit 
	cmp al,'a' 							; below "a"? 
	jb L2 
	cmp al,'z'							 ; above "z"? 
	ja L2 
	and BYTE PTR [rsi],11011111b 		 ; convert the char 
L2: inc rsi 								; next char 
	jmp L1 
L3: ret 
Str_ucase ENDP 

call ExitProcess
main ENDP
END
