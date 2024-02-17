.MODEL small
.STACK 100h
.DATA
m db 'Xin chao cac ban! $'
.CODE
PS:
        mov ax , @data
        mov ds,ax
        lea dx,m        ; Ham hien 1 xau (kt bang '$'len man hinh)
        mov ah,9
        int 21h
        mov ah,4ch       ; Tro ve DOS
        int 21h
END PS
