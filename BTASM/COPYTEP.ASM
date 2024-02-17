INCLUDE LIB1.ASM                 ;Xac lap Macro Xoa man hinh va
.MODEL SMALL
.STACK 100H
.DATA
                m1       db 13,10,'Chuc Nang Copy Tep '
                         db 13,10,'--------------------'
                         db 13,10,'Vao ten tep can copy : $'
                m2       db 13,10,'Vao tep copy : $'
                errorO   db 13,10,'Khong mo duoc tiep !$'
                errorR   db 13,10,'Khong doc duoc tiep !$'
                errorW   db 13,10,'Khong ghi duoc tep !$'
                errorC   db 13,10,'Khong dong duoc tiep !$'
                theteps  dw ?
                thetepd  dw ?
                buff     db 40
                         db ?
                file_name   db 40  dup(?)
                dem      db 512 dup(?)
                tieptuc  db 13,10,'Co tiep tuc khong ? (Y/N) $'
.CODE                               
         PS :
                MOV      AX,@DATA
                MOV      DS,AX
         L0 :
                CLRSCR                            ;Xoa man hinh
                HienString      m1                ;Hien thong bao m1
                LEA             DX,buff
                CALL            GET_FILE_NAME     ;Vao ten tep can copy di
                LEA             DX,file_name      ;Chuc nang mo tep da co de doc
                MOV             AL,0              ; AL = 0 de doc
                MOV             AH,3DH            ; Chuc nang mo tiep da co
                INT             21H
                JNC             L1                ;Hoi bien co Carry 0 thi L1 , 1 Hien thong bao
                HienString      errorO
                JMP             Exit
         L1 :
                MOV             theteps,AX        ; Dua the tep vao bien theteps
                HienString      m2                      
                LEA             DX,buff
                CALL            GET_FILE_NAME
                LEA             DX,file_name
                MOV             CX,0              ;Khong xac lap properties
                MOV             AH,3CH            ;Func tao tep moi va mo
                INT             21H
                JNC             L2
                HienString      errorO
                JMP             DONGTEPS
          L2 :
                MOV             thetepd,AX        ; Cat vao the tep can copy den
          L3 :
                MOV             BX,theteps
                LEA             DX,dem
                MOV             CX,512            ; So luong byte can doc
                MOV             AH,3FH            ; Chuc nang doc tep 521 byte
                INT             21H
                JNC             L4
                HienString      errorR
                JMP             DONGTEPD
          L4:
                AND             AX,AX
                JZ              L5
                MOV             BX,thetepd
                LEA             DX,dem
                MOV             CX,AX
                MOV             AH,40H
                INT             21H
                JNC             L5
                HienString      errorW
                JMP             DONGTEPD
          L5:
                JMP             L3
    DONGTEPD:
                MOV             BX,thetepd
                MOV             AH,3EH
                INT             21H
                JNC             DONGTEPS
                HienString      errorC
    DONGTEPS:
                MOV             BX,theteps
                MOV             AH,3EH
                INT             21H
                JNC             Exit
                HienString      errorC
         Exit:
                HienString      tieptuc
                MOV             AH,1
                INT             21H
                CMP             AL,'Y'
                JNE             Thoat
                JMP             L0
        Thoat :
                MOV             AH,4CH
                INT             21H
 INCLUDE LIB3.ASM
 END PS