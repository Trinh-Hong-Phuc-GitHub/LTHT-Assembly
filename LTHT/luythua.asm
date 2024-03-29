.model small
.stack 100h

.data
M1 db 13,10,'Hay vao a : $'
M2 db 13,10,'Hay vao n : $'
crlf db 13,10,'$'
M3 db ' luy thua $'
M4 db ' la : $'
M5 db 13,10,'Co tiep tuc CT (c/k)? $'
.code
start:
mov ax,@data
mov ds,ax
clrscr
HienString M1 ; Hiện thông báo M1 (‘Hay vao a : ‘)
call VAO_SO_N ; Nhận giá trị a
mov bx,ax ; bx = a
HienString M2 ; Hiện thông báo M2 (‘Hay vao n : ‘)
call VAO_SO_N ; Nhận giá trị n
mov cx,ax ; cx = n
HienString crlf ; Quay đầu dòng và xuống hàng
mov ax,bx ; ax=a
call HIEN_SO_N ; Hiện giá trị a lên màn hình
HienString M3 ; Hiện 2 chữ ‘ luy thua ‘
mov ax,cx ; ax=n
call HIEN_SO_N ; Hiện giá trị n lên màn hình
HienString M4 ; Hiện chữ ‘ la : ‘
mov ax,1 ; Gán ax=1
and cx,cx ; Liệu giá trị n (cx=n) có bằng 0 ?
jz HIEN ; Nếu bằng 0 thì nhảy đến nhãn HIEN
 LAP: ; còn không thì thực hiện vòng lặp tính a lũy thừa n
 mul bx ; ax=ax*bx
 loop LAP
  HIEN:
  call HIEN_SO_N ; Hiện giá trị a lũy thừa n (giá trị có trong ax)
  HienString M5 ; Hiện thông báo M5 (‘Co tiep tục CT (c/k) ?’ )
cmp al,'c' ; Ký tự vừa nhận có phải là ký tự ‘c’ ?
jne exit ; Nếu không phải thì nhảy đến nhãn Exit (về DOS)
jmp start ; Còn không thì quay về đầu (bắt đầu lại chương trình)
    mov ah,1
    int 21h
    exit:
    mov ah, 4ch           ; function to terminate the program
    int 21h                 ; execute
end start