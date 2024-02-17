.MODEL SMALL
.DATA
EXTRN n:word
PUBLIC FV
FV dw ?
.CODE
PUBLIC GIAITHUA
GIAITHUA PROC
        MOV     CX,n
        MOV     AX,1
        CMP     CX,2
        JP      L2
      L1:
         MUL    CX
         LOOP   L1
      L2:
         MOV    FV,AX
         RET
GIAITHUA ENDP
END



