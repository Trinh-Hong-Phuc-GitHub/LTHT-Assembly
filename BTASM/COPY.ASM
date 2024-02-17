INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
 ct1            db  13,10,' Hay vao ten tep can copy di : $'
 ct2	       db 13,10,' Hay vao ten tep can copy den : $' 
 Err_O       db 13,10,' Khong mo duoc tep !$'
 Err_R       db 13,10,' Khong doc duoc tep !$'
 Err_W      db 13,10,' Khong ghi duoc tep !$'
 Err_C       db 13,10,' Khong dong duoc tep !$'
 buff             db 30
		          db ?
 file_name   db 30 dup(?)
  file_name1   db 30 dup(?)
 the_tep1   dw   ?
 the_tep2   dw   ?
  the_tep3   dw   ?
 dem          db     512 dup(?)
 tieptuc      db 13,10,' Co tiep tuc CT (c/k) ? $'
.CODE
 PS:
		mov  ax,@data
mov  ds,ax
   L_CT0:
           CLRSCR
           HienString ct1	; Hiện thông báo ct1		
           lea    dx,buff	
           call   GET_FILE_NAME ; Vào tên tệp cần copy đi       
           lea    dx,file_name	; Mở tệp đã có để đọc
           mov  al,0
           mov  ah,3dh               
           int     21h
           jnc     L_CT1
           HienString  Err_O	; Hiện thông báo Err_O nếu mở tệp bị lỗi (CF=1)
           jmp   Exit_CT
    L_CT1:
           mov  the_tep1,ax	; Nếu mở tệp tốt thì đưa thẻ tệp có trong AX -> biến thetep1
           HienString  ct2
           lea    dx,buff
           call   GET_FILE_NAME ; Vào tên tệp cần copy đến
           lea    dx,file_name	; Tạo tệp mới và mở
           mov  cx,0		; Không đặt thuộc tính nào cho tệp
           mov  ah,3ch              
           int    21h
           jnc   L_CT2
           HienString  Err_O	; Hiện thông báo Err_O nếu tạo và mở tệp bị lỗi (CF=1)
           jmp DONG_TEP1
    L_CT2:
           mov  the_tep2,ax     ; Nếu mở tệp tốt thì đưa thẻ tệp có trong AX -> biến thetep2     
    L_CT3:
           mov  bx,the_tep1	; Đọc 512 byte từ tệp copy đi -> vùng nhớ dem
           mov  cx,512        
           lea    dx,dem
           mov  ah,3fh
           int    21h
           jnc    L_CT4
           HienString Err_R	; Hiện thông báo Err_R nếu đọc tệp bị lỗi (CF=1)
           jmp  DONG_TEP2
    L_CT4:
          and   ax,ax		; Số lượng byte thực tế đã đọc được bằng 0?
          jz      DONG_TEP1	; Đúng băng 0 (hết tệp) thì nhảy đến đóng các tệp và kết thúc,
          mov  bx,the_tep2	; còn không bằng 0 thì tiến hành ghi tệp
          mov  cx,ax		; Đưa số lượng byte đọc được vào CX
          lea    dx,dem		; Trỏ đến vùng đệm chứa số liệu cần ghi
          mov  ah,40h		; Chức năng ghi tệp
          int     21h
          jnc    L_CT5
          HienString Err_W	; Hiện thông báo Err_W nếu không ghi được tệp (CF=1),
          jmp  DONG_TEP2
    L_CT5:
          jmp  DONG_TEP2		; Ghi tệp tốt thì nhảy về tiếp tục đọc và ghi
    DONG_TEP2:
          mov  bx,the_tep2	; Chức năng đóng tệp
          mov  ah,3eh
          int     21h
INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
 ct1            db  13,10,' Hay vao ten tep can copy di : $'
 ct2	       db 13,10,' Hay vao ten tep can copy den : $' 
 Err_O       db 13,10,' Khong mo duoc tep !$'
 Err_R       db 13,10,' Khong doc duoc tep !$'
 Err_W      db 13,10,' Khong ghi duoc tep !$'
 Err_C       db 13,10,' Khong dong duoc tep !$'
 buff             db 30
		          db ?
 file_name   db 30 dup(?)
  file_name1   db 30 dup(?)
 the_tep1   dw   ?
 the_tep2   dw   ?
  the_tep3   dw   ?
 dem          db     512 dup(?)
 tieptuc      db 13,10,' Co tiep tuc CT (c/k) ? $'
.CODE
 PS:
		mov  ax,@data
mov  ds,ax
   L_CT0:
           CLRSCR
           HienString ct1	; Hiện thông báo ct1		
           lea    dx,buff	
           call   GET_FILE_NAME ; Vào tên tệp cần copy đi       
           lea    dx,file_name	; Mở tệp đã có để đọc
           mov  al,0
           mov  ah,3dh               
           int     21h
           jnc     L_CT1
           HienString  Err_O	; Hiện thông báo Err_O nếu mở tệp bị lỗi (CF=1)
           jmp   Exit_CT
    L_CT1:
           mov  the_tep1,ax	; Nếu mở tệp tốt thì đưa thẻ tệp có trong AX -> biến thetep1
           HienString  ct2
           lea    dx,buff
           call   GET_FILE_NAME ; Vào tên tệp cần copy đến
           lea    dx,file_name	; Tạo tệp mới và mở
           mov  cx,0		; Không đặt thuộc tính nào cho tệp
           mov  ah,3ch              
           int    21h
           jnc   L_CT2
           HienString  Err_O	; Hiện thông báo Err_O nếu tạo và mở tệp bị lỗi (CF=1)
           jmp DONG_TEP1
    L_CT2:
           mov  the_tep2,ax     ; Nếu mở tệp tốt thì đưa thẻ tệp có trong AX -> biến thetep2     
    L_CT3:
           mov  bx,the_tep1	; Đọc 512 byte từ tệp copy đi -> vùng nhớ dem
           mov  cx,512        
           lea    dx,dem
           mov  ah,3fh
           int    21h
           jnc    L_CT4
           HienString Err_R	; Hiện thông báo Err_R nếu đọc tệp bị lỗi (CF=1)
           jmp  DONG_TEP2
    L_CT4:
          and   ax,ax		; Số lượng byte thực tế đã đọc được bằng 0?
          jz      DONG_TEP1	; Đúng băng 0 (hết tệp) thì nhảy đến đóng các tệp và kết thúc,
          mov  bx,the_tep2	; còn không bằng 0 thì tiến hành ghi tệp
          mov  cx,ax		; Đưa số lượng byte đọc được vào CX
          lea    dx,dem		; Trỏ đến vùng đệm chứa số liệu cần ghi
          mov  ah,40h		; Chức năng ghi tệp
          int     21h
          jnc    L_CT5
          HienString Err_W	; Hiện thông báo Err_W nếu không ghi được tệp (CF=1),
          jmp  DONG_TEP2
    L_CT5:
          jmp  DONG_TEP2		; Ghi tệp tốt thì nhảy về tiếp tục đọc và ghi
    DONG_TEP2:
          mov  bx,the_tep2	; Chức năng đóng tệp
          mov  ah,3eh
          int     21h
          jnc    DONG_TEP1
          HienString Err_C  	; Hiện thông báo Err_C nếu không đóng được tệp (CF=1)
    DONG_TEP1:
          mov  bx,the_tep1	; Chức năng đóng tệp
          mov  ah,3eh
          int    21h
          jnc    Exit_CT
          HienString Err_C
    Exit_CT:
          Hienstring tieptuc      ; Hiện thông báo tieptuc
          mov  ah,1                   ; Chờ 1 ký tự từ bàn phím
          int     21h                         
          cmp   al,'c'                 ; Ký tự vào có phải 'c'
          jne    Thoat_CT         ; Không phải 'c' thì nhảy đế Thoat_CT,
          jmp    L_CT0		; còn đúng là 'c' thì nhảy về L_CT0
   Thoat_CT:                     
			mov  ah,4ch		; Về DOS
			int     21h
INCLUDE lib3.asm		; lib3.asm chứa CT con GET_FILE_NAME
			END  PS