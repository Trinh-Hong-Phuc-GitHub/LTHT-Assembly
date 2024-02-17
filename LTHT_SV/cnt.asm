INCLUDE lib1.asm
.MODEL small
.DATA
m1 db 13,10,'         CHUC NANG KIEM TRA CONG MAY IN NOI TIEP'
   db 13,10,'         ----------***----------'
   db 13,10,13,10,'     May tinh co cong may in noi tiep khong: $'
m2 db 'Khong $'
m3 db 'Co $'
m4 db 13,10,'     Nhan phim bat ki de thoat: $'
.CODE
PUBLIC _KIEMTRA_CONG_MAYIN_NOITIEP
_KIEMTRA_CONG_MAYIN_NOITIEP PROC
    CLRSCR 
    HienString m1

    ; Kiểm tra cổng máy in nối tiếp
    mov ah, 2       ; Đặt chức năng kiểm tra cổng máy in nối tiếp
    mov dl, 0       ; LPT1 (cổng máy in nối tiếp 1), thay đổi số này nếu bạn muốn kiểm tra cổng khác

    int 17h
    jc L1           ; Nếu carry flag (CF) được thiết lập, không có cổng máy in nối tiếp
    HienString m3  ; Nếu CF không được thiết lập, có cổng máy in nối tiếp
    jmp Exit

L1:
    HienString m2

Exit:
    HienString m4
    mov ah, 1
    int 21h
    ret

_KIEMTRA_CONG_MAYIN_NOITIEP ENDP
END
