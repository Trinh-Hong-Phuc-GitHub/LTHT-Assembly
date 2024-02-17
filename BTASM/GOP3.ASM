INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
ct1 db 13,10,'Hay vao ten tep can copy di : $'
ct2 db 13,10,'Hay vao ten tep can copy den : $'
Err_O db 13,10,'Khong mo duoc tep !$'
Err_R db 13,10,'Khong doc duoc tep !$'
Err_W db 13,10,'Khong ghi duoc tep !$'
Err_C db 13,10,'Khong dong duoc tep !$'
buff db 30
db ?
file_name db 30 dup(?)
the_tep1 dw ?
the_tep2 dw ?
dem db 512 dup(?)
tieptuc db 13,10,'Co tiep tuc CT (c/k) ? $'
.CODE
PS:
mov ax, @data
mov ds, ax
L_CT0:
CLRSCR
HienString ct1
lea dx, buff
call GET_FILE_NAME
lea dx, file_name
mov al, 0
mov ah, 3Dh
int 21h
jnc L_CT1
HienString Err_O
jmp Exit_CT
L_CT1:
mov the_tep1, ax
HienString ct2
lea dx, buff
call GET_FILE_NAME
lea dx, file_name
mov cx, 0
mov ah, 3Dh
int 21h
jnc L_CT2
HienString Err_O
jmp Exit_CT
L_CT2:
mov the_tep2, ax
L_CT3:
mov bx, the_tep1
mov cx, 512
lea dx, dem
mov ah, 3Fh
int 21h
jnc L_CT4
HienString Err_R
jmp DONG_TEP2
L_CT4:
and ax, ax
jz DONG_TEP1
mov bx, the_tep2
mov cx, ax
lea dx, dem
mov ah, 40h
int 21h
jnc L_CT5
HienString Err_W
jmp DONG_TEP2
L_CT5:
; Di chuyển con trỏ tới cuối tệp
mov bx, the_tep1
mov cx, 0
mov dx, 2
mov ah, 42h
int 21h
; Di chuyển con trỏ tới cuối tệp
mov bx, the_tep2
mov cx, 0
mov dx, 2
mov ah, 42h
int 21h
jmp L_CT3
DONG_TEP2:
mov bx, the_tep2
mov ah, 3Eh
int 21h
jnc DONG_TEP1
HienString Err_C
DONG_TEP1:
mov bx, the_tep1
mov ah, 3Eh
int 21h
jnc Exit_CT
HienString Err_C
Exit_CT:
Hienstring tieptuc
mov ah, 1
int 21h
cmp al, 'c'
jne Thoat_CT
jmp L_CT0
Thoat_CT:
mov ah, 4Ch
int 21h
INCLUDE lib3.asm
END PS