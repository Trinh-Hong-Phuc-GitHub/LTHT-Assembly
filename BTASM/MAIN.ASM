INCLUDE lib1.asm
.MODEL SMALL
.STACK
.DATA
        Mn       db 13,10,'Hay vao N : $'
        M1       db 13,10,'Giai thua cua : $'
        M2       db 13,10,' la : $'
        cont     db 13,10,'Co tiep tuc chuong trinh (Y/N)?$'
PUBLIC  n
        n dw ?
EXTRN   FV;WORD
.CODE
EXTRN GIAITHUA:PROC
PS:
        MOV     AX,@DATA
        MOV     DS,AX
     L0:
        CLRSCR
        HienString      Mn
        CALL            VAO_SO_N
        MOV             N,AX
        HienString      M1
        CALL            HIEN_SO_N
        HienString      M2
        CALL            GIAITHUA
        MOV             AX,FV
        CALL            HIEN_SO_N
        HienString      cont
        MOV             AH,1
        INT             21H
        CMP             AL,'Y'
        JNE             EXIT
        JMP             L0
      EXIT:
        MOV             AH,4CH
        INT             21H
INCLUDE  LIB2.ASM
END      PS

        
