INCLUDE D:\LTHT\BaiTap1.asm
.MODEL small
.STACK 100h
.DATA 

msg1 db 13,10, 'Nhap vao a: $'
msg2 db 13,10, 'Nhap vao b: $'
msg db 13,10, '$'
msg3 db 'Luy thua a $'
msg4 db 'la: $'
msg5 db 'Co tiep tuc CT(c/k)? $'

.CODE 
SUPEMAN:
mov ax, @data
mov ds, ax
clrscr; xoa-man-hinh
HienString msg1; hien sau
call VAO_SO_N
mov bx,ax; bx=a
HienString msg2;
call VAO_SO_N;
mov cx,ax
HienString msg
mov ax,bx
call HIEN_SO_N
HienString msg3
mov ax,cx
call HIEN_SO_N;
HienString msg4
mov ax,1
and cx, cx
jz L2

L1:
    mul bx
    loop L1;

L2:
    call HIEN_SO_N
    HienString msg5
    mov ah, 1
    int 21h
    cmp al, 'c'
    jne exit
    jmp SUPEMAN

exit:
    mov ah, 4ch
    int 21h
    INCLUDE D:\LTHT\LIB2.asm
    CODE ends
    END SUPEMAN