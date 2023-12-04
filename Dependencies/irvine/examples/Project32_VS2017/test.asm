; Test.asm

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
.data
wordVal SWORD -101			; FF9Bh

.code
main proc
	mov	dx, 0
	mov 	ax, wordVal			; DX:AX = 0000FF9Bh (+65, 435)
	cwd
	mov 	bx, 2				; BX is the divisor
	idiv	bx					; divide DX : AX by BX (signed operation)

	invoke ExitProcess,0
main endp
end main