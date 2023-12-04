INCLUDE Irvine32.inc

.386
.model flat, stdcall
.stack 4096
BUFFER_SIZE = 501
.data
    buffer BYTE ?
    stringLength DWORD ?
    str1 BYTE "Write Number",0dh,0ah,0
    str2 BYTE "Push :",0
    str3 BYTE "pop  :",0

.code
main Proc
    mov eax,0
    .WHILE eax<10
        inc eax
        call WriteDec
        call crlf
    .ENDW
main ENDP
END main