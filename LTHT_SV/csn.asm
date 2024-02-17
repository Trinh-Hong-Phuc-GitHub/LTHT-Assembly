INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
M1  db 10,13,'Hay vao n : $'
M2  db 10,13,'Hay vao q : $'
M3  db 10,13,'Hay vao u1 : $ '
M4  db 10,13, 'Tong cap so nhan la : $'      
M5  db 10,13,'Co tiep tuc (c/k) ? $'
.CODE
 PUBLIC _CSNTONG
_CSNTONG PROC
	L0:
	mov  ax,@data
	mov  ds,ax
	CLRSCR		; Xóa màn hình
	HienString M1	; Hiện thông báo M1 (‘Hay vao n : ‘)
	call   VAO_SO_N	; Nhận giá trị n
	mov  cx,ax		; cx = n
	HienString M2	; Hiện thông báo M2 (’Hay vao q : ‘)
	call   VAO_SO_N	; Nhận giá trị q
	mov  bx,ax		; bx = q
	HienString M3	; Hiện thông báo M3 (’Hay vao u1 : ‘)
	call   VAO_SO_N	; Nhận giá trị u1
	mov  si,ax		; si = ax = u1 (si = tổng = u1; ax =ui và lúc đầu bằng u1)
	dec   cx		; Giảm cx đi 1 (n-1)
    L1:
	mul   bx		; ax = ax*bx = ui 
	add   si,ax		; si  = tổng
	loop  L1
HienString M4	; Hiện thông báo M3 (‘Tong cap so nhan la : ‘)
mov  ax,si		; Chuyển tổng từ si đến ax
	call  HIEN_SO_N	; Hiện tổng cấp số nhân
	HienString M5	; Hiện dòng nhắc M4 (‘Co tiep tuc CT (c/k) ?’)
	mov  ah,1		; Chờ nhận 1 ký tự từ bàn phím
	int     21h
	cmp  al,'c'		; Ký tự vừa nhận có phải là ký tự ‘c’ ?
	jne    Exit		; Nếu không phải thì nhảy đến nhãn Exit (về DOS)
	jmp   L0		; Còn không thì quay về đầu (bắt đầu lại chương trình)
   Exit:
	ret
	_CSNTONG endp
INCLUDE lib2.asm
	END 
