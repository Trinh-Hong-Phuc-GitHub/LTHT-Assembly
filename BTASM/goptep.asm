INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
m1 db 13,10,' COPY TEP'
   db 13,10,'   ----'
   db 13,10,13,10,' Vao tep can copy di: $'
m2 db 13,10,'Vao ten tep can chuyen den: $'
Err_O db 13,10,'Khong mo duoc tep!$'
Err_R db 13,10,'Khong doc duoc tep!$'
Err_W db 13,10,'Khong ghi duoc tep!$'
Err_C db 13,10,'Khong dong duoc tep!$'
theteps dw ?
thetepd dw ?
buff db 30
     db ?
file_name db 30 dup(?)
dem db 512 dup(?)
tieptuc db 13,10,'Co tiep tuc chuong trinh$'
.CODE
 PUBLIC _GOPTEP
_GOPTEP PROC
        mov ax, @data
        mov ds, ax
     L0:
        CLRSCR
        HienString m1        ; Hien thong bao chuong trinh
        lea dx, buff
        call GET_FILE_NAME   ; Vao tep can copy 
        lea dx, file_name    ; Mo tep da co de doc
        mov al, 0
        mov ah, 3dh
        int 21h
        jnc L1
        HienString Err_O     ; Hien thong bao Err_O neu mo tep bi loi (CF=1)
        jmp KT
     L1:
        mov theteps, ax      ; Neu mo duoc tep thi dua the tep co trong ax vao bien theteps
        HienString m2
        lea dx, buff
        call GET_FILE_NAME   ; Vao ten tep can copy den
        lea dx, file_name    ; Tao tep moi va mo  
        mov al, 1      
        mov ah, 3dh
        int 21h
        jnc L2
        HienString Err_O     ; Hien thong bao Err_O neu tao va mo tep bi loi (CF=1)
        jmp DONGTEPS
     L2:
        mov thetepd, ax      ; Neu mo tep tot thi dua the tep co trong ax vao bien thetepd
        mov bx, ax
        mov al, 2
        xor cx, cx
        mov dx, cx
        mov ah, 42h
        int 21h
     L3:
        mov bx, theteps      ; Doc 512 byte tu tep can copy vao vung nho dem
        mov cx, 512
        lea dx, dem
        mov ah, 3fh
        int 21h
        jnc L4
        HienString Err_R     ; Hien thong bao Err_R neu doc tep bi loi(CF=1)
        jmp DONGTEPD
     L4:
        and ax, ax           ; So luong byte da doc duoc thuc te = 0
        jz DONGTEPD          ; Neu = 0 thi nhay den dong tep va ket thuc
        mov bx, thetepd      ; Nguoc lai thi tien hanh ghi tep
        mov cx, ax           ; Dua so luong byte da doc duoc vao cx
        lea dx, dem          ; Tro den vung dem chua so lieu can ghi
        mov ah, 40h          ; Chuc nang ghi tep
        int 21h
        jnc L5
        HienString Err_W     ; Hien thong bao Err_W neu khong ghi duoc tep (CF=1)
        jmp DONGTEPD
     L5:
        jmp L3               ; Ghi tep tot thi nhay ve tiep tuc doc ghi
     DONGTEPD:
        mov bx, thetepd      ; Chuc nang dong tep
        mov ah, 3eh
        int 21h
        jnc DONGTEPS
        HienString Err_C     ; Hien thoong bao Err_C neu khong dong duoc tep (CF=1)
     DONGTEPS:
        mov bx, theteps      ; Chuc nang dong tep
        mov ah, 3eh
        int 21h
        jnc KT
        HienString Err_C
     KT:
        HienString tieptuc   ; Hien thong bao tiep tuc
        mov ah, 1            ; Cho mot ky tu nhap tu ban phim
        int 21h
        cmp al, 'c'          ; Ky tu co phai 'c'
        jnc Thoat            ; Khong phai c thi nhay den Thoat
        jmp L0               ; Con dung la c thi nhay den L0
     Thoat:
        mov ah, 4ch          ; Ve DOS
        int 21h
        _GOPTEP endp
INCLUDE lib3.asm             ; lib4 chua ct con getfillename
END 
