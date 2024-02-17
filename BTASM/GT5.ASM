.MODEL small
.STACK 100h
.CODE
PS:
        mov ax,1        ; Gan ax =1
        mov cx,5        ; Vong for 5
     L1:
        mul cx          ; ax * cx -> ax  ax * ax de day vao ax
        loop L1         ; cx = cx -1 ? = 0 
        mov ah,4ch
        int 21h
        END PS


