
.MODEL small
.STACK 100h
.DATA
m db 'Xin chao cac ban!',0
.CODE
PS:
        mov ax , @data
        mov ds,ax
        lea si,m
     L1:
        mov al,[si] 
        and al,al
        jz KT
        mov ah,0eh
        int 10h
        inc si
        jmp L1

     KT:
        mov ah,4ch       ; Tro ve DOS
        int 21h
END PS
