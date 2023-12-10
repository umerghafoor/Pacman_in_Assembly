includelib Winmm.lib


.data 
	pacman_chomp		db 'pacman-chomp.wav',0  
	pacman_beginning	db 'pacman_beginning.wav',0 
	pacman_eatfruit	db 'pacman_eatfruit.wav',0 
	pacman_eatghost	db 'pacman_eatghost.wav',0 
	pacman_death		db 'pacman_death.wav',0
    
	PlaySound   PROTO,
					pszSound:PTR BYTE,
					hmod:DWORD,
					fdwSound:DWORD


.code 
PrintIntro PROC

	call Clrscr
	mov eax, 14
	CALL SetTextColor
	mov ecx, 28
	mov edx, OFFSET intro1 - 57

	BoardLoop:
		ADD edx, 57
		CALL writestring
		CALL CRLF

		Loop BoardLoop

	INVOKE PlaySound, OFFSET pacman_beginning, NULL, 11h
	
	mov eax, 15
	CALL SetTextColor

	mov  edx, OFFSET userNameOutput
	mov  ecx, SIZEOF userNameOutput
	call writestring

	mov  edx, OFFSET userName
    mov  ecx, SIZEOF userName
    call ReadString

	mov  edx, OFFSET userDecOutput
	mov  ecx, SIZEOF userDecOutput
	call writestring

    call ReadChar
	mov  userDec, al

	RET 
PrintIntro ENDP

PrintMazeBoard PROC uses esi
	call Clrscr
	mov eax, 1
	CALL SetTextColor
	mov ecx, 2265
	mov esi, OFFSET row1

	mov eax, levelup
	add esi, eax

	mov eax,'#'
	BoardLoop:
		ADD esi, 1
		mov dl, [esi]

		cmp dl,"#"
		je blueColor
		cmp dl,"o"
		je redColor
			mov eax, 2
			CALL SetTextColor
			jmp notblueColor
		blueColor:
			mov eax, 1
			CALL SetTextColor
			jmp notblueColor
		redColor:
			mov eax, 4
			CALL SetTextColor
			jmp notblueColor
		notblueColor:


		mov al, [esi]
		CALL writechar

	Loop BoardLoop

	mov dl, PacPosX
	mov dh, PacPosY
	CALL GoTOXY
	mov eax, 14
	CALL SetTextColor
	mov al, pacman
	CALL writechar

	RET 
PrintMazeBoard ENDP

PrintWon PROC

	call Clrscr
	mov eax, 14
	CALL SetTextColor
	mov ecx, 26
	mov edx, OFFSET won1 - 57

	BoardLoop:
		ADD edx, 57
		CALL writestring
		CALL CRLF

		Loop BoardLoop

	INVOKE PlaySound, OFFSET pacman_beginning, NULL, 11h
	
	RET 
PrintWon ENDP

PrintGameOver PROC

	call Clrscr
	mov eax, 4
	CALL SetTextColor
	mov ecx, 23
	mov edx, OFFSET gameOver1 - 57

	BoardLoop:
		ADD edx, 57
		CALL writestring
		CALL CRLF

		Loop BoardLoop

	INVOKE PlaySound, OFFSET pacman_beginning, NULL, 11h
	
	RET 
PrintGameOver ENDP


PrintCurrentScore PROC
	mov edx, 0
	mov eax, 0
	mov dl, 66
	mov dh, 8
	CALL GoToXY
	mov eax, Score
	call writedec
	RET
PrintCurrentScore ENDP

PrintCurrentLevel PROC
	mov edx, 0
	mov eax, 0
	mov dl, 68
	mov dh, 26
	CALL GoToXY
	mov al, levelno
	call writedec
	RET
PrintCurrentLevel ENDP

PrintCurrentLife PROC
	mov edx, 0
	mov eax, 0
	mov dl, 68
	mov dh, 24
	CALL GoToXY
	mov al, noOfLives
	call writedec
	RET
PrintCurrentLife ENDP