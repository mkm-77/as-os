; Reversing a String
.386
.model flat , stdcall
.stack 4096
ExitProcess PROTO, dwExitCode : DWORD

.data
aName BYTE "Abraham Lincoln" , 0
namesize = ($ -aname) -1

.code
main PROC
; push the name on the stack
mov ecx , namesize
mov esi , 0

L1:movzx eax, aname[esi]
   push eax
   inc esi
   loop L1

; Pop the name from the stack, in reverse,
; and store in the aname array
mov ecx, namesize
mov esi, 0

L2:pop eax
   mov aname[esi], al
   inc esi
   loop L2
   INVOKE ExitProcess, 0
main ENDP
END main
