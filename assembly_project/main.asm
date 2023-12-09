INCLUDE Irvine32.inc
INCLUDE pacprint.inc
INCLUDE pacman.inc
INCLUDE goast.inc
INCLUDE data.inc


.code
main PROC

	loop1:
	call PrintIntro
	cmp userDec,'n'
	je exitGame
	
	mov eax,00
	call DELAY

	call runGame

	jmp loop1

	exitGame:
		exit

main ENDP

runGame PROC
	
	mov inputChar," "

	mov score,0

	call PrintMazeBoard
	call SpawnGhosts

	INVOKE PlaySound, OFFSET pacman_beginning, NULL, 11h

	;jmp wonGame
		mov levelup, 0
		mov PacCollPos,656
		mov PacPosX,24
		mov PacPosY,23

	gameLoop:
		
		cmp fakescore,225
		je wonGame

		;Delay
		mov eax,150
		call DELAY

		;Printing the score
		call PrintCurrentScore
		call PrintCurrentLevel

		;check for portals
		cmp portaHitFlag,1
		je portalHit

		; get user key input:
		mov eax,0
		mov al,inputChar
		mov oldinputChar,al
		call ReadKey
		cmp al,1h
		je noKeyPressed
			mov inputChar,al
		noKeyPressed:

		; exit game if user types 'x':
		cmp inputChar,"x"
		je exitGame

		cmp inputChar,"p"
		je pauseGame

		cmp inputChar,"w"
		je moveUp

		cmp inputChar,"s"
		je moveDown

		cmp inputChar,"a"
		je moveLeft

		cmp inputChar,"d"
		je moveRight

		jmp gameLoop

		moveUp:
			mov PacCollVal, -28
			CALL PacmanCollision
			CMP CollisionFlag, 1
			je oldInputhandeling
			mov dh, PacPosY
			mov dl, PacPosX
			CALL GoToXY
			mov al, 20h
			CALL writechar
			dec PacPosY
			mov dh, PacPosY
			CALL GoToXY
			mov al, 'v'
			CALL writechar
			
		jmp gameLoop

		moveDown:
			mov PacCollVal, 28
			CALL PacmanCollision
			CMP CollisionFlag, 1
			je oldInputhandeling
			mov dh, PacPosY
			mov dl, PacPosX
			CALL GoToXY
			mov al, 20h
			CALL writechar
			inc PacPosY
			mov dh, PacPosY
			CALL GoToXY
			mov al, '^'
			CALL writechar
		jmp gameLoop

		moveLeft:
			mov PacCollVal, -1
			CALL PacmanCollision
			CMP CollisionFlag, 1
			je oldInputhandeling
			mov dh, PacPosY
			mov dl, PacPosX
			CALL GoToXY
			mov al, 20h
			CALL writechar
			SUB PacPosX, 2
			mov dl, PacPosX
			CALL GoToXY
			mov al, '>'
			CALL writechar
		jmp gameLoop

		moveRight:
			mov PacCollVal, 1
			CALL PacmanCollision
			CMP CollisionFlag, 1
			je oldInputhandeling
			mov dh, PacPosY
			mov dl, PacPosX
			CALL GoToXY
			mov al, 20h
			CALL writechar
			ADD PacPosX,2
			mov dl, PacPosX
			CALL GoToXY
			mov al, '<'
			CALL writechar
		jmp gameLoop

		oldInputhandeling:
			mov al, oldinputChar
			mov inputChar,al
		jmp gameloop

		pauseGame:
			call PauseState
			mov inputChar,077h
		jmp gameLoop

	jmp gameLoop
	portalHit:
		INVOKE PlaySound, OFFSET pacman_eatghost, NULL, 11h
		cmp inputChar,'d'
		je rightPortal
		mov bx,PacCollPos
		add PacCollPos,27
		mov dh, PacPosY
		mov dl, PacPosX
		CALL GoToXY
		mov al, 20h
		CALL writechar
		ADD PacPosX,54
		mov dl, PacPosX
		CALL GoToXY
		mov al, '<'
		CALL writechar

		mov portaHitFlag, 0
		mov boardArray[bx],'@'
		jmp gameLoop

	rightPortal:
		
		mov bx,PacCollPos
		add PacCollPos,-27
		mov dh, PacPosY
		mov dl, PacPosX
		CALL GoToXY
		mov al, 20h
		CALL writechar
		ADD PacPosX,-54
		mov dl, PacPosX
		CALL GoToXY
		mov al, '<'
		CALL writechar

		mov portaHitFlag, 0
		mov boardArray[bx],'@'
	jmp gameLoop

	wonGame:
		mov fakescore,0
		add levelno, 1
		cmp levelno, 3
		je wontheWholeGame
		
		add levelup, 2267
		mov PacCollPos,656
		add PacCollPos,785
		mov PacPosX,26
		mov PacPosY,23
		INVOKE PlaySound, OFFSET pacman_beginning, NULL, 11h
		call PrintMazeBoard
		jmp gameLoop

	wontheWholeGame:
		call PrintWon
		mov eax,500
		call DELAY

	exitGame:
	ret
runGame ENDP



END main
