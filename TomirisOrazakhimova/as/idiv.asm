; ml64 /c idiv.asm
; link /subsystem:console idiv.obj kernel32.Lib MyLib-64.obj /ENTRY:main /largeaddressaware:no

ExitProcess 	proto
WriteInt64		proto
Crlf 			proto

.code
main proc
  mov rax,-25
  mov bl,5
  idiv bl
  call WriteInt64
  call Crlf
  call ExitProcess
main ENDP
END
