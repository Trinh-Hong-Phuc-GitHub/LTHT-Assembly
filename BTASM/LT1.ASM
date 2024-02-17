INCLUDE lib1.asm
_stack segment
db 100h dup(?)
_stack ends

        data  segment
           m1    db 13,10,'Nhap a : $'
           m2    db 13,10,'Nhap n : $'
           xh    db 13,10,'$'
           m3    db ' luy thua $'
           m4    db ' la : $'
           m5    db 13,10,'Co tiep tuc chuong trinh (Y/N)?$'
           incorrect db 13,10,'N khong hop le , Hay nhap lai!(An nut bat ky de tiep tuc)$'
        data   ends
        code   segment
        assume CS:code,DS:data, SS:_stack
        PS :
            mov          AX,data
            mov          DS,AX
            clrscr
            HienString   m1
            call         VAO_SO_N
            mov          BX,AX
        L_R:
            HienString   m2
            call         VAO_SO_N
            and          AX,AX
            jns          LX
            HienString   incorrect
            mov          AH,1
            int          21H
            jmp          L_R


        LX:
            mov          CX,AX
            HienString   xh
            mov          AX,BX
            call         HIEN_SO_N
            HienString   m3
            mov          AX,CX
            call         HIEN_SO_N
            HienString   m4
            mov          AX,1
            and          CX,CX
            jz           L2
         L1:
            mul          BX
            loop         L1
         L2:
            call         HIEN_SO_N
            HienString   m5
            mov          AH,1
            int          21h
            cmp          AL,'Y'
            jne          EXIT
            jmp          PS
        EXIT:
            mov          AH,4Ch
            int          21h
INCLUDE  lib2.asm
code     ends
END      PS



















