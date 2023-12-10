

.code 

PacmanCollision PROC USES ebx
	mov ebx, 0
	mov bx, PacCollPos
	add bx, PacCollVal
	CMP boardArray[bx], '#'
	je HitWall
	CMP boardArray[bx], '.'
	je HitDotSmall
	CMP boardArray[bx], 'o'
	je HitDotBig
	CMP boardArray[bx], '@'
	je HitPortal

	mov CollisionFlag, 0
	JMP ExitProc

	HitWall:
		mov CollisionFlag, 1
		JMP ExitProcWall

	HitDotSmall:
		add Score, 1 
		add fakescore,1
		mov eax,0
		mov al,PacPosX
		add esi,eax
		
		mov CollisionFlag, 0
		INVOKE PlaySound, OFFSET pacman_chomp, NULL, 11h
		JMP ExitProc

	HitDotBig:
		add Score, 2 
		add fakescore,2
		mov CollisionFlag, 0
		INVOKE PlaySound, NULL, NULL, 0
		INVOKE PlaySound, OFFSET pacman_eatfruit, NULL, 11h
		JMP ExitProc

	HitPortal:
		mov portaHitFlag,1

	JMP ExitProc


	ExitProc:
	mov PacCollPos, bx
	mov boardArray[bx],' '
	ExitProcWall:
	RET
PacmanCollision ENDP


PauseState PROC
	mov edx, 0
	mov eax, 0
	mov dl, 60
	mov dh, 10
	CALL GoToXY
	mov edx, OFFSET pauseGameVar
	call writeString
	call ReadInt
	mov edx, 0
	mov eax, 0
	mov dl, 60
	mov dh, 10
	CALL GoToXY
	mov edx, OFFSET NotPauseGameVar
	call writeString
	
	RET
PauseState ENDP

hittheGoast PROC uses eax ebx
	mov eax, 0
	mov ebx, 0

	mov al, goastPosX
	cmp PacPosX, al
	jne notcollideX
		mov al, goastPosY
		cmp PacPosY, al
		jne notcollideX

		INVOKE PlaySound, OFFSET pacman_death, NULL, 0

			cmp score,225
			jae wonGame

			mov levelup, 0
			mov PacCollPos, 656
			mov PacPosX, 24
			mov PacPosY, 23
		;goast 
			mov moveDirection, 0
			mov goastCollisionFlag, 0
			mov GoastCollPos, 405
			mov goastPosX,26
			mov goastPosY,14
			add noOfLives,-1

	notcollideX:
	ret

	wonGame:
	
		mov moveDirection, 0
		mov goastCollisionFlag, 0
		mov GoastCollPos,405
		add GoastCollPos,784
		mov goastPosX,26
		mov goastPosY,14

		add levelup, 2267
		mov PacCollPos,656
		add PacCollPos,785
		mov PacPosX,26
		mov PacPosY,23

		add noOfLives,-1

	ret

hittheGoast ENDP
