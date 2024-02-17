INCLUDE lib1.asm
.MODEL small
.DATA
        M1 db 10,13,'Hay vao so luong thanh phan:$'
        M2 db 10,13,'a[$'
        M3 db '] = $'
        M4 db 10,13,'Day so vua vao la : $'
        M5 db '   $'
        M6 db 10,13,'Tong day so nguyen la : $'
        M7 db 13,10,'Co tiep tuc chuong trinh (Y/N)?$'
        sltp dw ?
        i    dw ?
        a dw 100 dup(?)
.CODE
        PS:
            mov          ax,@data
            mov          ds,ax
            CLRSCR
            HienString   M1
            CALL         VAO_SO_N
            MOV          sltp,ax
            MOV          CX,AX
            LEA          BX,A
            MOV          I,0
         L1:
            HienString   M2
            MOV          AX,I
            CALL         HIEN_SO_N
            HienString   M3
            CALL         VAO_SO_N
            MOV          [BX],AX
            INC          I
            ADD          BX,2
            LOOP         L1
            HienString   M4
            MOV          CX,SLTP
            LEA          BX,A
         L2:
            MOV          AX,[BX]
            CALL         HIEN_SO_N
            HienString   M5
            ADD          BX,2
            LOOP         L2

            HienString   M6
            MOV          CX,SLTP
            LEA          BX,A
            XOR          AX,AX
         L3:
            ADD          AX,[BX]
            ADD          BX,2
            LOOP         L3
            CALL         HIEN_SO_N
            HienString   M7
            MOV          AH,1
            INT          21H
            CMP          AL,'Y'
            JNE          EXIT
            JMP          PS
         EXIT:
            MOV          AH,4CH
            INT          21H
INCLUDE LIB2.ASM
END PS












