INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
        m1 db 13,10,'Hay vao n : $'
        m2 db 13,10,'Giai thua cua $'
        m3 db 'la : $'
        m4 db 13,10,'Co tiep tu chuong trinh (Y/N)?$'
.CODE
        PS:mov AX,@data
           mov DS,AX
        L0:
           clrscr
           HienString    m1
           call          VAO_SO_N
           HienString    m2
           call          HIEN_SO_N
           HienString    m3
           mov           CX,AX
           mov           AX,1
           cmp           CX,2
           jb            L2
        L1:
           mul           CX
           loop          L1
        L2:
           call          HIEN_SO_N
           HienString    m4
           mov           AH,1
           int           21h
           cmp           AL,'Y'
           jne           EXIT
           jmp           PS
       EXIT:
           mov           AH,4Ch
           int           21h

INCLUDE  lib2.asm        
END      PS       

                









