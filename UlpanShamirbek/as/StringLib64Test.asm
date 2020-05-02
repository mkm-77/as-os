;ml64 /c StringLib64Test.asm

;link /subsystem:console StringLib64Test.obj kernel32.Lib MyLib-64.obj /ENTRY:main /largeaddressaware:no
;ml64 StringLib64Test.asm /link /subsystem:console StringLib64Test.obj MyLib-64.obj /ENTRY:main /largeaddressaware:no


Str_compare proto
Str_length proto 
Str_copy proto 
ExitProcess proto
WriteString proto 
WriteInt64 proto
Crlf proto 

include include\invoke_macros.asm
includelib lib\kernel32.lib
includelib lib\user32.lib


.data 
source BYTE "AABCDEFGAABCDFG",0 ; size = 15 
target BYTE 20 dup(0)
msg1 BYTE "Length of source is ",0
msg2 BYTE "string_1 and string_2 are equal",0
msg3 BYTE "compare after copy",0
msg4 BYTE "string_1 is less than string_2",0


.code 
main PROC 
	mov rdx,offset msg1
	call WriteString
	mov   rcx,offset source 
    call  Str_length 			 
	call WriteInt64
	call Crlf

	mov   rsi,offset source 
	mov   rdi,offset target 
	call str_copy     		

	call  str_compare  	 ; ZF = 1, strings are equal
	mov rdx,OFFSET msg2
	call WriteString
	call Crlf
	call Crlf

	mov rdx,OFFSET msg3
    call WriteString
	call Crlf

	

; Change the first character of the target string, and compare them again. 
	mov   target,'B' 
	call  str_compare ; CF = 1, source < target 
	mov rdx,OFFSET msg4
	call WriteString
	call Crlf
	mov   rcx,0
	call  ExitProcess 

main ENDP
END