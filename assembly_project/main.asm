INCLUDE Irvine32.inc
includelib Winmm.lib

.data

strScore BYTE "Your score is: ",0
score db 0

xPos BYTE 20
yPos BYTE 20

xCoinPos BYTE ?
yCoinPos BYTE ?

inputChar BYTE ?
oldinputChar BYTE ?


pacman BYTE "O"

PacPosX db 26
PacPosY db 23

PacPosLastX db 2 	
PacPosLastY db 0

CollisionFlag db ?

PacCollVal dw 1
PacCollValLast dw 2
PacCollPos dw 657 	;Pac-Man collision board value

GhostColors db 0Ch, 0Bh, 0Dh, 0Eh
GhostXs db 23, 25, 28, 30
GhostYs db 14, 14, 14, 14



row1  db "# # # # # # # # # # # # # # # # # # # # # # # # # # # #    ___________________ ",0
row2  db "# . . . . . . . . . . . . . . . . . . . . . . . . . . #   |                   |",0  
row3  db "# . # # . # # . # # . . . # # . # # # # # . # # # # . #   | ### ### ### ###   |",0  
row4  db "# o # # . # # . # # # . # # # . # # . . . . # #   # o #   | #   #   # # #  #  |",0  
row5  db "# . # # . # # . # # # # # # # . # # # # # . # # # # . #   | ### #   # # ####  |",0  ;64 for current score
row6  db "# . # # . # # . # # . # . # # . # # # # # . # # . # . #   |   # #   # # #  #  |",0  
row7  db "# . # # # # # . # # . . . # # . # # . . . . # # . # . #   | ### ### ### #  #  |",0  
row8  db "# . # # # # # . # # . . . # # . # # # # # . # # . # . #   |                   |",0  
row9  db "# . . . . . . . . . . . . # # . . . . . . . . . . . . #   |                   |",0  
row10 db "# # # # # # . # # . # #   # #   # # . # # . # # # # # #   |===================|",0  ;64 for past scores
row11 db "# # # # # # . # # . # #   # #   # # . # # . # # # # # #   | Press Key         |",0  
row12 db "# # # # # # . # #                     # # . # # # # # #   |===================|",0  
row13 db "# # # # # # . # #   # # # - - # # #   # # . # # # # # #   |  p -> Pause       |",0  
row14 db "# # # # # # . # #   #             #   # # . # # # # # #   |  x -> Exit        |",0  
row15 db "            .       #             #       .               |  w -> Move Up     |",0  
row16 db "# # # # # # . # #   #             #   # # . # # # # # #   |  s -> Move Down   |",0  
row17 db "# # # # # # . # #   # # # # # # # #   # # . # # # # # #   |  a -> Move Left   |",0  
row18 db "# # # # # # . # #                     # # . # # # # # #   |  d -> Move Right  |",0  
row19 db "# # # # # # . # # # # # # # # # # # # # # . # # # # # #   |                   |",0 
row20 db "# # # # # # . # # # # # # # # # # # # # # . # # # # # #   |===================|",0  
row21 db "# . . . . . . . . . . . . # # . . . . . . . . . . . . #   |  Lives            |",0  
row22 db "# . # # # # . # # # # # . # # . # # # # # . # # # # . #   |===================|",0  
row23 db "# . . . # # . # # # # # . # # . # # # # # . #     # . #   |    O    O    O    |",0  
row24 db "# o # # # # . . . . . . .     . . . . . . . # # # # o #   |                   |",0  
row25 db "# . # # . . . # # # # # # # # # # # . # # . #     # . #   |                   |",0  
row26 db "# . # # # # . # # # # # # # # # # # . # # . # # # # . #   |                   |",0  
row27 db "# . . . . . . . . . . . . . . . . . . # # . . . . . . #   |                   |",0 
row28 db "# # # # # # # # # # # # # # # # # # # # # # # # # # # #   |___________________|",0 


boardArray  db '############################',
			   '#..........................#', 
			   '#.##.##.##...##.#####.####.#', 
			   '#o##.##.###.###.##....####o#',
			   '#.##.##.#######.#####.####.#', 
			   '#.##.##.##.#.##.#####.##.#.#', 
			   '#.#####.##...##.##....##.#.#', 
			   '#.#####.##...##.#####.##.#.#',
			   '#............##............#',
			   '######.##.## ## ##.##.######', 
			   '######.##.## ## ##.##.######'
		    db '######.##          ##.######',
			   '######.## ######## ##.######', 
			   '######.## #      # ##.######', 
			   '@     .   #      #   .      ', 
			   '######.## #      # ##.######',
			   '######.## ######## ##.######', 
			   '######.##          ##.######', 
			   '######.##############.######', 
			   '######.##############.######',
			   '#............##............#' 
		    db '#.####.#####.##.#####.####.#', 
			   '#...##.#####.##.#####.#  #.#', 
			   '#o####.......  .......####o#',
			   '#.##...###########.##.#  #.#', 
			   '#.####.###########.##.####.#', 
			   '#..................##......#', 
			   '############################',


	pacman_chomp		db 'pacman-chomp.wav',0  
	pacman_beginning	db 'pacman_beginning.wav',0  ; Replace with the actual path to your sound file
    PlaySound   PROTO,
					pszSound:PTR BYTE,
					hmod:DWORD,
					fdwSound:DWORD


userName   BYTE    100 DUP(?)
pauseGameVar   BYTE    "Enter to Continue",0
NotPauseGameVar   BYTE    "Press Key       ",0

userNameOutput BYTE "Enter Your Name : ",0

userDec   BYTE    ?
userDecOutput BYTE "Play Game (y/n)  : ",0

					
intro1  db "          ____   _    ____ __  __    _    _   _         ",0
intro2  db "         |  _ \ / \  / ___|  \/  |  / \  | \ | |        ",0
intro3  db "         | |_) / _ \| |   | |\/| | / _ \ |  \| |        ",0
intro4  db "         |  __/ ___ \ |___| |  | |/ ___ \| |\  |        ",0
intro5  db "         |_| /_/   \_\____|_|  |_/_/   \_\_| \_|        ",0
intro6  db "                                                        ",0
intro7  db "                        @@@%#***#@@@@                   ",0
intro8  db "                    @@*::::::::::::::-#@@               ",0
intro9  db "                  @+::::::::::::::::::::-#@             ",0
intro10  db "                @+::::::::::::::::::::::::#@            ",0
intro11  db "               %::::::::::::::::::::::::*@              ",0
intro12  db "              %::::::::::::::@@@=:::::*@                ",0
intro13  db "             @-::::::::::::::%@@-:::*@                  ",0
intro14  db "            @=::::::::::::::::::::*@                    ",0
intro15  db "            %:::::::::::::::::::#@                      ",0
intro16  db "            %:::::::::::::::::#@                        ",0
intro17  db "            %:::::::::::::::::-@@                       ",0
intro18  db "            @:::::::::::::::::::+@                      ",0
intro19  db "            @#::::::::::::::::::::#@                    ",0
intro20  db "             @=::::::::::::::::::::-%@                  ",0
intro21  db "              @=:::::::::::::::::::::=@                 ",0
intro22  db "               @*::::::::::::::::::::::#@               ",0
intro23  db "                @@=:::::::::::::::::::::-@@             ",0
intro24  db "                  @@*::::::::::::::::::-#@              ",0
intro25  db "                     @@#+::::::::::-*%@@                ",0
intro26  db "                          @@@@@@@@@                     ",0
intro27  db "                                                        ",0
intro28  db "                                                        ",0


won1  db "                                                        ",0
won2  db "    __   __           __        __                      ",0
won3  db "    \ \ / /__  _   _  \ \      / /__  _ __              ",0
won4  db "     \ V / _ \| | | |  \ \ /\ / / _ \| '_ \             ",0
won5  db "      | | (_) | |_| |   \ V  V / (_) | | | |            ",0
won6  db "      |_|\___/ \__,_|    \_/\_/ \___/|_| |_|            ",0                                                                                                                                                  
won7  db "                                                        ",0
won8  db "                                                        ",0
won9  db "              @@@@@@@@@@@@@@@@@@@@@@@@                  ",0
won10  db "              @@@@@@@@@@@@@@@@@@@@@@@@                  ",0
won11  db "              @@@@@@@@@@@@@@@@@@@@@@@@                  ",0
won12  db "       @@@@@@@@@@@@@@          @@@@@@@@@@@@@@           ",0
won13  db "      @@@@@@@@@@@@@@@          *@@@@@@@@@@@@@@          ",0
won14  db "      @@@@=   @@@@@@@@@@@@     *@@@@@@   -@@@@          ",0
won15  db "      @@@@=   @@@@@@@@@@@@     *@@@@@@   -@@@@          ",0
won16  db "      @@@@@@@@@@@@@@@@@@@@     *@@@@@@@@@@@@@@          ",0
won17  db "       @@@@@@@@@@@@@@@@@@@     %@@@@@@@@@@@@@           ",0
won18  db "              #@@@@@@@@@@@@@@@@@@@@@@#                  ",0
won19  db "                @@@@@@@@@@@@@@@@@@@@                    ",0
won20  db "                 :@@@@@@@@@@@@@@@@:                     ",0
won21  db "                     .@@@@@@@@.                         ",0
won22  db "                        @@@@                            ",0
won23  db "                   +@@@@@@@@@@@@+                       ",0
won24  db "                   @@@@@@@@@@@@@@                       ",0
won25  db "                                                        ",0
won26  db "                                                        ",0
                                                    
                                                    
                                                    
                                                                                                              
                                                              


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
	mov eax,Black +(white*16)
	
	mov inputChar," "

	mov score,0

	call PrintMazeBoard
	call SpawnGhosts
	INVOKE PlaySound, OFFSET pacman_beginning, NULL, 0
	gameLoop:
		
		cmp score,225
		je wonGame

		;Delay
		mov eax,50
		call DELAY

		;Printing the score
		call PrintCurrentScore

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
			INVOKE PlaySound, OFFSET pacman_chomp, NULL, 0
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
			INVOKE PlaySound, OFFSET pacman_chomp, NULL, 0
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
			INVOKE PlaySound, OFFSET pacman_chomp, NULL, 0
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
			INVOKE PlaySound, OFFSET pacman_chomp, NULL, 0
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

	wonGame:
		call PrintWon
		mov eax,500
		call DELAY
		call PrintMazeBoard

	exitGame:
	ret
runGame ENDP

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

	INVOKE PlaySound, OFFSET pacman_beginning, NULL, 0
	
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


PrintMazeBoard PROC
	call Clrscr
	mov eax, 15
	CALL SetTextColor
	mov ecx, 28
	mov edx, OFFSET row1 - 80

	BoardLoop:
		ADD edx, 80
		CALL writestring
		CALL CRLF

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

	INVOKE PlaySound, OFFSET pacman_beginning, NULL, 0
	
	RET 
PrintWon ENDP


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
		mov eax,0
		mov al,PacPosX
		mov esi,OFFSET row24
		add esi,eax
		mov [row24], "H"
		
		mov CollisionFlag, 0
		JMP ExitProc

	HitDotBig:
		add Score, 2 
		mov CollisionFlag, 0
		mov eax, 0
		CALL GetMSeconds
		JMP ExitProc

	HitPortal:
		mov PacCollVal, 28
		mov dh, PacPosY
		mov dl, PacPosX
		CALL GoToXY
		mov al, '@'
		CALL writechar
		mov PacPosX,18
		mov dl, PacPosX
		mov dh, PacPosY
		CALL GoToXY
		mov al, 'v'
		CALL writechar

		JMP ExitProc


	JMP ExitProc

	ExitProc:
	mov PacCollPos, bx
	mov boardArray[bx],0
	ExitProcWall:
	RET
PacmanCollision ENDP

PrintCurrentScore PROC
	mov edx, 0
	mov eax, 0
	mov dl, 66
	mov dh, 8
	CALL GoToXY
	mov al, Score
	call writedec
	RET
PrintCurrentScore ENDP


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

SpawnGhosts PROC USES eax ecx edx esi
	mov eax, 0
	mov ecx, 4
	mov esi, 0

	Spawn:
		mov al, GhostColors[esi]
		Call SetTextColor
		mov dl, GhostXs[esi]
		mov dh, GhostYs[esi]
		Call GotoXY
		mov al, 'H'
		Call WriteChar
		inc esi
		loop Spawn

	ret
SpawnGhosts ENDP

END main
