
.data

moveDirection BYTE ?


goastFeet BYTE "O"

goastPosX db 22
goastPosY db 23


goastCollisionFlag db ?
goastportaHitFlag db 0

goastCollVal dw 1
goastCollPos dw 656

GhostColors db 0Ch, 0Bh, 0Dh, 0Eh
GhostXs db 23, 25, 28, 30
GhostYs db 14, 14, 14, 14


.code



GoastCollision PROC USES ebx eax edx
	mov ebx, 0
	mov eax, 0
	mov edx, 0

	mov bx, GoastCollPos
	add bx, GoastCollVal
	mov ax, bx
	

	mov dl,boardArray[bx]
	mov goastFeet,dl
	

	mov bx, ax
	
	CMP boardArray[bx], 't'
	je HitWall
	CMP boardArray[bx], '#'
	je HitWall

	mov goastCollisionFlag, 0
	JMP ExitProc

	HitWall:
		mov goastCollisionFlag, 1
		JMP ExitProcWall


	ExitProc:
	mov GoastCollPos, bx
	;mov boardArray[bx],0
	ExitProcWall:
	RET
GoastCollision ENDP

