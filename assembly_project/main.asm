INCLUDE Irvine32.inc
INCLUDE data.inc
INCLUDE pacprint.inc
INCLUDE pacman.inc
INCLUDE goast.inc


.code
main PROC

	loop1:

	;call PrintGameOver
	;mov eax,50000
	;call DELAY

	call PrintIntro
	cmp userDec,'n'
	je exitGame
	
	

	call runGame

	jmp loop1

	exitGame:
		exit

main ENDP

runGame PROC
	
	mov inputChar," "

	mov score,0

	call PrintMazeBoard

	INVOKE PlaySound, OFFSET pacman_beginning, NULL, 11h

	;jmp wonGame
		mov levelup, 0
		mov levelno, 1
		mov PacCollPos, 656
		mov PacPosX, 24
		mov PacPosY, 23
		mov noOfLives, 3 

	;goast 
		mov moveDirection, 0
		mov goastCollisionFlag, 0
		mov GoastCollPos, 405
		mov goastPosX,26
		mov goastPosY,14
	

	gameLoop:
		

		call hittheGoast

		cmp fakescore,225
		je wonGame

		cmp noOfLives, 0
		jbe lifeGone

		call hittheGoast
		call runGoast


		;Delay
		mov eax,150
		call DELAY

		;Printing the score
		call PrintCurrentScore
		call PrintCurrentLevel
		call PrintCurrentLife

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

			mov eax, 14
		    CALL SetTextColor
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

			mov eax, 14
		    CALL SetTextColor
			
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

			mov eax, 14
		    CALL SetTextColor
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

			mov eax, 14
		    CALL SetTextColor
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

		lifeGone:
			call PrintGameOver
			mov eax,10000
			call DELAY

		jmp exitGame

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

runGoast PROC uses edx
	

	;check for portals
	;cmp portaHitFlag,1
	;je portalHit

	cmp moveDirection,0
	je moveUp

	cmp moveDirection,1
	je moveDown

	cmp moveDirection,2
	je moveLeft

	cmp moveDirection,3
	je moveRight


	moveUp:
		mov goastCollVal, -28
		CALL GoastCollision
		CMP goastCollisionFlag, 1
		je takeRandominput

		mov eax, 2
		CALL SetTextColor
		mov dh, goastPosY
		mov dl, goastPosX
		;dec dh
		CALL GoToXY
		mov al, goastFeet
		CALL writechar
		
		mov eax, 5
		CALL SetTextColor
		dec goastPosY
		mov dh, goastPosY
		mov dl, goastPosX
		CALL GoToXY
		mov al, "G"
		CALL writechar
			
		jmp exitGame

	moveDown:
		mov GoastCollVal, 28
		CALL GoastCollision
		CMP goastCollisionFlag, 1
		je takeRandominput

		mov eax, 2
		CALL SetTextColor
		mov dh, goastPosY
		mov dl, goastPosX
		;dec dh
		CALL GoToXY
		mov al, goastFeet
		;mov al, " "
		CALL writechar

		mov eax, 5
		CALL SetTextColor
		inc goastPosY
		mov dh, goastPosY
		mov dl, goastPosX
		CALL GoToXY
		mov al, 'G'
		CALL writechar
		jmp exitGame

	moveLeft:
		mov GoastCollVal, -1
		CALL GoastCollision
		CMP goastCollisionFlag, 1
		je takeRandominput

		mov eax, 2
		CALL SetTextColor
		mov dh, goastPosY
		mov dl, goastPosX
		;dec dh
		CALL GoToXY
		mov al, goastFeet
		;mov al, " "
		CALL writechar

		mov eax, 5
		CALL SetTextColor
		SUB goastPosX, 2
		mov dl, goastPosX
		mov dh, goastPosY
		CALL GoToXY
		mov al, 'G'
		CALL writechar
	jmp exitGame

	moveRight:
		mov GoastCollVal, 1
		CALL GoastCollision
		CMP goastCollisionFlag, 1
		je takeRandominput


		mov eax, 2
		CALL SetTextColor
		mov dh, goastPosY
		mov dl, goastPosX
		;dec dh
		CALL GoToXY
		mov al, goastFeet
		;mov al, " "
		CALL writechar

		mov eax, 5
		CALL SetTextColor
		ADD goastPosX,2
		mov dl, goastPosX
		mov dh, goastPosY
		CALL GoToXY
		mov al, 'G'
		CALL writechar
		jmp exitGame

	takeRandominput:
		mov eax,4
		call Randomize
		call RandomRange
		and eax,11b

		mov moveDirection,2
		mov moveDirection,al

	

	exitGame:
	ret
runGoast ENDP



END main
