INCLUDE LIB1.ASM
.MODEL SMALL
.STACK 100H
.DATA
        m1 db 13,10,'May tinh dang dung co DMA khong ?       $'
        m2 db 13,10,'May tinh dang dung co cong COM nao khong ?     $'
        yes db 'Yes$'
        no  db 'No$'
        m3 db 13,10,'So luong cong COM la : $'
        m4 db 13,10,'Dia chi cac cong COM la : $'
        space db ' $'
.CODE
        PS :
                MOV      AX,@DATA
                MOV      DS,AX

                CLRSCR
                HienString       m1
                INT              11H    ;0:410H se duoc dua vao AL
                                        ;0:411H se duoc dua vao AH
                MOV              AL,AH
                SHR              AL,1
                JC               L1     ; Carry = 1 nhay Yes ; Carry = 0 nhay No
                HienString       no
                jmp              L2
            L1:
                HienString       yes
            L2:
                HienString       m2
                AND              AL,00000111b
                JNZ              L3
                HienString       no
                JMP              Exit
            L3:
                HienString       yes
                MOV              CL,AL
                XOR              CH,CH
                HienString       m3
                ADD              AL,30H
                MOV              AH,0EH         ;Ham hien ky tu ASCII len man hinh
                INT              10H
                HienString       m4
                XOR              AX,AX
                MOV              ES,AX
                MOV              BX,400H
             L4:
                MOV             AX,ES:[BX]
                CALL            Hien_Hexa
                HienString      space
                ADD             BX,2
                LOOP            L4
            Exit :
                MOV              AH,1
                INT              21H
                MOV              AH,4CH
                INT              21H
INCLUDE LIB2.ASM
END PS













































