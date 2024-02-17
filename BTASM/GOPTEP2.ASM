; Khai báo biến
.DATA
	The_tep1 db 13,10, 'Hay vao ten tep 1: $'
    The_tep2 db 13,10, 'Hay vao ten tep 2: $'
	FileExs db 13,10, 'Tep ton tai:$'
	FileNotExs db 13,10, 'Tep khong ton tai$'
	buff db 512 dup(?)
	count dw ?

; Nhập tên tệp thứ 1 và thứ 2
.code
mov ax, @data
mov ds, ax

; Nhập tên tệp thứ 1
mov dx, offset The_tep1
call GET_FILE_NAME

; Nhập tên tệp thứ 2
mov dx, offset The_tep2
call GET_FILE_NAME

; Mở tệp thứ 1 để ghi
mov ah, 3dh
mov al, 1
mov dx, offset The_tep1
int 21h

; Đưa con trỏ về cuối tệp thứ 1
mov bx, ax
mov al, 2
xor cx, cx
mov dx, cx
mov ah, 42h
int 21h

; Mở tệp thứ 2 để đọc
mov ah, 3dh
mov al, 0
mov dx, offset The_tep2
int 21h

; Đọc từng sector của tệp thứ 2
@@loop:
mov ah, 3fh
mov bx, ax
mov cx, 512
mov dx, offset buff
int 21h

; Kiểm tra xem đã hết tệp chưa
cmp ax, 0
je @@end

; Ghi sector vào tệp thứ 1
mov ah, 40h
mov bx, ax
mov cx, 512
mov dx, offset buff
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

; Thông báo thành công
HienString "Gộp tệp thành công!"

; Kết thúc chương trình
int 20h

; Hàm nhập tên tệp
GET_FILE_NAME PROC
	push ax bx cx dx
	mov  ah,0ah	; Chuc nang nhan 1 xau tu
	int  21h	; ban phim va de vao buff
	mov  bx,dx	; bx tro den dau buf
	inc  bx		; bx tro den byte chua so luong ky tu da vao
	mov  cl,[bx]	; cl=so luong ky tu thuc te da vao
	xor  ch,ch	; ch=0 de cx=cl
	inc  bx		; bx tro den byte dau tien chua ky tu da vao
	add  bx,cx	; bx tro den byte chua 0dh (Enter)
	mov  [bx],ch	; Cho byte do bang \0
	pop  dx cx bx ax
	ret
GET_FILE_NAME ENDP