; Khai báo biến
INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
the_tep1 db 13,10, 'Hay vao ten tep 1 : $'
the_tep2 db 13,10, 'Hay vao ten tep 2 : $'
buf db 512 dup(?)
count dw ?

; Nhập tên tệp thứ 1
.code
mov ax, @data
mov ds, ax

; Nhập tên tệp thứ 2
mov dx, offset the_tep2
call GET_FILE_NAME

; Mở tệp thứ 1 để ghi
mov ah, 3dh
mov al, 1
mov dx, offset the_tep1
int 21h

; Đưa con trỏ về cuối tệp
mov bx, ax
mov al, 2
xor cx, cx
mov dx, cx
mov ah, 42h
int 21h

; Mở tệp thứ 2 để đọc
mov ah, 3dh
mov al, 0
mov dx, offset the_tep2
int 21h

; Đọc từng sector của tệp thứ 2
@@loop:
mov ah, 3fh
mov bx, ax
mov cx, 512
mov dx, offset buf
int 21h

; Kiểm tra xem đã hết tệp chưa
cmp ax, 0
je @@end

; Ghi sector vào tệp thứ 1
mov ah, 40h
mov bx, ax
mov cx, 512
mov dx, offset buf
int 21h

jmp @@loop

@@end:
; Đóng cả 2 tệp
mov ah, 3eh
mov bx, ax
int 21h

mov bx, ax
mov ah, 3eh
int 21h

; Kết thúc chương trình
int 20h

; Hàm nhập tên tệp
GET_FILE_NAME proc
mov dx, offset the_tep1
mov ah, 0ah
int 21h
ret
GET_FILE_NAME endp
INCLUDE lib3.asm
END