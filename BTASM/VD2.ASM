_STACK  segment
db 100h dup(?)
_STACK ends
data segment
  m db 'Hello world! Good Luck$'
data ends

code segment
 assume cs:code, ds:data ,ss:_STACK
PS:
        mov ax, data
        mov ds, ax
        lea dx, m
        mov ah,9
        int 21h
        mov ah,4ch
        int 21h
code ends
END PS
