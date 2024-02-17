.MODEL small
.STACK 100h
.DATA
        m1 db 13,10,'Nhap ky tu : $'

.CODE
PS:
        mov ax,@data
        mov ds,ax

     L0:
        mov AH,1
        int 21h
        cmp AL,0dh ;Xem co phai enter khong ?
        je  Exit

        mov AL,m1
        mov AH,0eh
        int 10h
     Exit :
           mov AH,4CH
           int 21h

END PS
