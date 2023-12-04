; Structure example(32 - bit)

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

Employee STRUCT                            
     IdNum BYTE "000000000"                
     LastName BYTE 30 DUP(0)               
     ;ALIGN WORD                           
     Years WORD 30                         
     ;ALIGN DWORD                          
     SalaryHistory DWORD 0, 0, 0, 0        
Employee ENDS

;// size of structure: 0x39, or 57 bytes

.data
employees Employee 5 DUP(<"111111111", "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", 0FFh, 4 DUP(0EEEEEEEEh)>)
; hex offsets:  00--08, 09-26, 27, 29-38.


.code
main proc
	mov esi,0
     mov eax,0
     mov ax, employees[esi].Years         ; AX = 0xFF

     mov edx,SIZEOF Employee


	invoke ExitProcess,0
main endp
end main