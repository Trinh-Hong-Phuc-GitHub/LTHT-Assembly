include lib1.asm
.model small
.stack 100h
.data
m1 db 13,10,'bai tap chia so'
   db 13,10,'--------------'
   db 13,10,13,10,' nhap so bi chia:$'
m2 db 13,10,'hay nhap so chia:$'
m3 db 13,10,'thuong la:$'
tieptuc db 13,10,'co tieo tuc ct (c/k)?$'
dautru db '-$'
daucham db '.$'
sai db 13,10,'nhap sai so chia, nhap lai!$'
.code
ps:
        mov ax,@data
        mov ds,ax
      L0:
        clrscr
        HienString M1
        call VAO_SO_N
        cmp ax,0 
        mov bx,ax
      LXX:
        HienString M2
        call VAO_SO_N
        cmp ax,0
        jg LX
        HienString sai
        mov ah,1
        int 21h
        jmp LXX
      LX:
        xchg ax,bx                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
        HienString M3
        and ax,ax
        jns L1
        HienString dautru
        neg ax
      L1:
        xor dx,dx
        div bx
        call HIEN_SO_N
        and dx,dx
        jz KT
        HienString daucham
        mov cx,3
        mov si,10
      L2:
        mov ax,dx
        mul si
        div bx
        call HIEN_SO_N
        and dx,dx
        jz KT
        loop L2
      KT:
        HienString tieptuc
        mov ah,1
        int 21h
        cmp  al,'c'
        jne Exit
        jmp PS
      Exit:
        mov ah,4ch
        int 21h
      INCLUDE lib2.asm
      END
                                                                                                                                                                                                                                                                                                                                                                                                                                                                


