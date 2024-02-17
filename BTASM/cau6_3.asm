INCLUDE lib1.asm
.MODEL small
.DATA
m1 db 13,10,'           CHUC NANG KIEM TRA CONG MAY IN NOI TIEP'
   db 13,10,'                   ----------***----------'
   db 13,10,13,10,'May tinh co cong may in noi tiep khong: $'
m2 db 'Khong $'
m3 db 'Co $'
m4 db 13,10,'Nhan phim bat ki de thoat: $'
.CODE
PUBLIC _KIEMTRA_CONG_MAYIN_NOITIEP
_KIEMTRA_CONG_MAYIN_NOITIEP PROC
    clrscr 
     L0:
        clrscr
        HienString m1
        int 11h ; gọi hàm hệ thống để kiểm tra cổng nối tiếp.
        shr ah, 6 ; để kiểm tra bit 6 của thanh ghi ah (kết quả trả về từ hàm gọi) để xem máy tính có cổng máy in nối tiếp hay không.
        jc L1 ;  (nhảy nếu có cờ nhớ). cf = 0 -> m2 Nếu bit 6 là 1, chương trình sẽ hiển thị "Không", nếu là 0, sẽ hiển thị "Có". 
        HienString m2
        jmp KT
     L1:
        HienString m3
     KT:
        HienString m4   ; Hien thong bao tiep tuc
        mov ah, 1            ; Cho mot ky tu nhap tu ban phim
        int 21h
        cmp al, 'c'          ; Ky tu co phai 'c'
        jnc Thoat            ; Khong phai c thi nhay den Thoat
        jmp L0               ; Con dung la c thi nhay den L0   
    Thoat:
        ret
_KIEMTRA_CONG_MAYIN_NOITIEP ENDP
END
