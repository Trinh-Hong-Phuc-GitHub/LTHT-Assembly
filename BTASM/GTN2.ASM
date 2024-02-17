.MODEL large
.DATA
        EXTRN _n:word
.CODE
 PUBLIC @GIAITHUA$qv

 @GIAITHUA$qv PROC

        MOV     CX,_n
        MOV     AX,1
        cmp     CX,2
        jb      L2
      L1:
        MUL     CX
        LOOP    L1
      L2:
         ret

 @GIAITHUA$qv   ENDP
 END
