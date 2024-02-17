.MODEL small
.DATA
     EXTRN   _n:word,_a:dword
.CODE
        PUBLIC @SUM$qv
        @SUM$qv PROC
                MOV     CX,_n
                MOV     AX,SEG _a
                MOV     ES,AX
                MOV     BX , OFFSET _a
                XOR     AX,AX
             L1:
                ADD     AX,ES:[BX]
                ADD     BX,2
                LOOP    L1
                RET
       @SUM$qv  ENDP
       END
            

