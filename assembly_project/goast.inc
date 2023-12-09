
.code
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
