.MODEL small
.DATA
        EXTRN _n:word
.CODE
 PUBLIC @GIAITHUA$qi
 @GIAITHUA$qi PROC
        PUSH    BP
        MOV     BP,SP
        MOV     CX,[BP+4]
        MOV     AX,1
        cmp     CX,2
        jb      L2
      L1:
        MUL     CX
        LOOP    L1
      L2:
        POP BP
        ret
 @GIAITHUA$qi   ENDP
 END
