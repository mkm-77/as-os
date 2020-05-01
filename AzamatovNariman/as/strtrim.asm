;ml64 /c strtrim.asm
;link /subsystem:console strtrim.obj kernel32.Lib MyLib-64.obj /ENTRY:main /largeaddressaware:no

;ml64 strtrim.asm /link /subsystem:console strtrim.obj MyLib-64.obj /ENTRY:main /largeaddressaware:no


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
msg1      BYTE "string_1 before trimming: ",0
msg2     BYTE "string_1 after trimming: ",0 

.code
	main PROC 
	mov rdx,OFFSET msg1
	call WriteString 
	mov rdx,OFFSET string_1 
	call WriteString 
	call Crlf 
	
	nvk Str_trim, ADDR string_1, '/' 
	mov rdx,OFFSET msg2 
	call WriteString 
	mov rdx,OFFSET string_1 
	call WriteString 
	call Crlf 
	ret 


Str_trim PROC 
	
	mov  rdi,offset string_1 		; prepare to call Str_length 
	nvk Str_length,rdi 				; returns the length in EAX 
	cmp  rax,0 						; is the length equal to zero? 
	je   L3 						; yes: exit now 
	mov  rcx,rax 					; no: ECX = string length 
	dec  rax 
	add  rdi,rax 					; point to last character 
L1: mov  al,[rdi]					; get a character    
	cmp  al,'/' 					; is it the delimiter?    
	jne  L2 						; no: insert null byte    
	dec  rdi					 	; yes: keep backing up 
	loop L1 						; until beginning reached 
	L2:  mov  BYTE PTR [rdi+1],0 	; insert a null byte 
	L3:  ret 
Str_trim ENDP 

call ExitProcess
main ENDP
END