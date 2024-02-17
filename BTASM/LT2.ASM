.MODEL small
.DATA
        EXTRN _a:word,_n:word
.CODE
        PUBLIC @LT$qv
        @LT$qv PROC
                MOV      BX,_a
                MOV      CX,_n
                MOV      AX,1
                AND      CX,CX
                JZ       L2
             L1:
                MUL      BX
                LOOP     L1
             L2:
                RET
        @LT$qv  ENDP
                END
