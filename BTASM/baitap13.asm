INCLUDE lib1.asm       ; Include file lib1.asm
.MODEL small           ; Chọn mô hình chương trình small
.STACK 100h            ; Đặt kích thước ngăn xếp (stack) là 100h
.DATA                  ; Phần khai báo dữ liệu
m1 db 13,10,'          CHUC NANG GOP TEP' ; Định nghĩa chuỗi m1 (dòng 1)
   db 13,10,'          -----------------'   ; Định nghĩa chuỗi m1 (dòng 2)
   db 13,10,13,10,'Hay vao ten tep thu nhat: $' ; Định nghĩa chuỗi m1 (dòng 3)
m2 db 13,10,'Hay vao ten tep thu hai: $' ; Định nghĩa chuỗi m2
m4 db 13,10,'Hay vao ten tep thu ba: $' ; Định nghĩa chuỗi m4
m3 db 13,10,'Gop tep thanh cong! $'       ; Định nghĩa chuỗi m3
Err_O db 13,10,'Khong mo duoc tep!$'       ; Định nghĩa chuỗi Err_O
Err_R db 13,10,'Khong doc duoc tep!$'      ; Định nghĩa chuỗi Err_R
Err_W db 13,10,'Khong ghi duoc tep!$'      ; Định nghĩa chuỗi Err_W
Err_C db 13,10,'Khong dong duoc tep!$'     ; Định nghĩa chuỗi Err_C
theteps dw ?            ; Khai báo biến theteps (word)
thetepd dw ?            ; Khai báo biến thetep (word)
thetepc dw ?            ; Khai báo biến thetep (word)
buff db 30              ; Khai báo vùng đệm "buff" có kích thước 30 bytes
     db ?               ; Một byte thừa cho kí tự null-terminated
file_name db 30 dup(?)  ; Khai báo mảng "file_name" có 30 bytes lưu tên file
dem db 512 dup(?)       ; Khai báo vùng đệm "dem" có kích thước 512 bytes
tieptuc db 13,10,'Co tiep tuc chuong trinh (c/k):$' ; Định nghĩa chuỗi "tieptuc"
.CODE                  ; Phần mã lệnh
PUBLIC _GOPTEP          ; Khai báo hàm _GOPTEP là public
_GOPTEP PROC
   START:              ; Nhãn START: bắt đầu của chương trình
        mov ax, @data   ; Đưa địa chỉ của phân vùng dữ liệu vào thanh ghi AX
        mov ds, ax      ; Sao chép giá trị của AX vào DS để trỏ đến phân vùng dữ liệu
     L0:
        clrscr           ; Gọi hàm CLRSCR để xóa màn hình
        HienString m1   ; Hiển thị chuỗi m1 ra màn hình
        lea dx, buff     ; Đưa địa chỉ của "buff" vào thanh ghi DX
        call GET_FILE_NAME ; Gọi hàm GET_FILE_NAME để nhập tên tệp cần sao chép
        lea dx, file_name ; Đưa địa chỉ của "file_name" vào DX để mở tệp
        mov al, 0         ; Đặt chức năng "mở tệp" (0) trong AL
        mov ah, 3dh       ; Đặt hàm dịch vụ "mở tệp" (3dh) trong AH
        int 21h           ; Gọi hàm ngắt 21h để mở tệp
        jnc L1            ; Nếu không có lỗi (CF = 0), nhảy đến nhãn L1
        HienString Err_O  ; Hiển thị thông báo lỗi Err_O nếu việc mở tệp gặp lỗi (CF = 1)
        jmp KT            ; Nhảy đến nhãn KT (kết thúc chương trình)
     L1:
        mov theteps, ax   ; Lưu handle của tệp đã mở vào biến theteps
        HienString m2     ; Hiển thị chuỗi m2 để yêu cầu tên tệp đích
        lea dx, buff       ; Đưa địa chỉ của "buff" vào DX
        call GET_FILE_NAME ; Gọi hàm GET_FILE_NAME để nhập tên tệp đích
        lea dx, file_name  ; Đưa địa chỉ của "file_name" vào DX để mở tệp đích
        mov al, 1          ; Đặt chức năng "mở tệp" (1) trong AL
        mov ah, 3dh        ; Đặt hàm dịch vụ "mở tệp" (3dh) trong AH
        int 21h            ; Gọi hàm ngắt 21h để mở tệp đích
        jnc L2             ; Nếu không có lỗi (CF = 0), nhảy đến nhãn L2
        HienString Err_O   ; Hiển thị thông báo lỗi Err_O nếu việc mở tệp đích gặp lỗi (CF = 1)
        jmp DONGTEPS       ; Nhảy đến nhãn DONGTEPS để đóng tệp nguồn và kết thúc chương trình
     L2:
        mov thetepd, ax   ; Lưu handle của tệp đích vào biến thetepd
        mov bx, ax         ; Sao chép handle của tệp đích vào BX
        mov al, 2          ; Đặt chức năng "đọc và ghi" (2) trong AL
        xor cx, cx         ; Xóa thanh ghi CX
        mov dx, cx         ; Sao chép giá trị của CX vào DX
        mov ah, 42h        ; Đặt hàm dịch vụ "tạo tệp và mở" (42h) trong AH
        int 21h            ; Gọi hàm ngắt 21h để tạo tệp đích
     L3:
        mov bx, theteps     ; Đưa handle của tệp nguồn vào BX
        mov cx, 512         ; Đặt CX bằng 512 (số byte cần đọc)
        lea dx, dem         ; Đưa địa chỉ của "dem" vào DX
        mov ah, 3fh         ; Đặt hàm dịch vụ "đọc từ tệp" (3fh) trong AH
        int 21h             ; Gọi hàm ngắt 21h để đọc dữ liệu từ tệp nguồn
        jnc L4              ; Nếu không có lỗi (CF = 0), nhảy đến nhãn L4
        HienString Err_R    ; Hiển thị thông báo lỗi Err_R nếu việc đọc tệp gặp lỗi (CF = 1)
        jmp DONGTEPD        ; Nhảy đến nhãn DONGTEPD để đóng tệp đích và kết thúc chương trình
     L4:
        and ax, ax           ; Kiểm tra xem số lượng byte đã đọc có bằng 0 không
        jz DONGTEPD          ; Nếu bằng 0, nhảy đến nhãn DONGTEPD để đóng tệp và kết thúc chương trình
        mov bx, thetepd      ; Đưa handle của tệp đích vào BX
        mov cx, ax           ; Đưa số lượng byte đã đọc vào CX
        lea dx, dem          ; Đưa địa chỉ của "dem" vào DX để ghi dữ liệu
        mov ah, 40h          ; Đặt hàm dịch vụ "ghi vào tệp" (40h) trong AH
        int 21h              ; Gọi hàm ngắt 21h để ghi dữ liệu vào tệp đích
        jnc L5               ; Nếu không có lỗi (CF = 0), nhảy đến nhãn L5
        HienString Err_W     ; Hiển thị thông báo lỗi Err_W nếu việc ghi tệp gặp lỗi (CF = 1)
        jmp DONGTEPD         ; Nhảy đến nhãn DONGTEPD để đóng tệp đích và kết thúc chương trình
     L5:
    HienString m3        ; Hiển thị thông báo "gộp tệp thành công từ tệp 1 sang tệp 2"
    ; Ghi dữ liệu từ tệp 1 vào tệp 2
    mov bx, theteps      ; Đưa handle của tệp thứ nhất vào BX
    mov cx, 512          ; Đặt CX bằng 512 (số byte cần đọc)
    lea dx, dem          ; Đưa địa chỉ của "dem" vào DX
    mov ah, 3fh          ; Hàm dịch vụ "đọc từ tệp" (3fh) trong AH
    int 21h              ; Gọi hàm ngắt 21h để đọc dữ liệu từ tệp thứ nhất
    jnc L6               ; Nếu không có lỗi (CF = 0), nhảy đến nhãn L6
    HienString Err_R     ; Hiển thị thông báo lỗi Err_R nếu việc đọc tệp thứ nhất gặp lỗi (CF = 1)
    L6:
    and ax, ax           ; Kiểm tra xem số lượng byte đã đọc có bằng 0 không
    jz DONGTEPD          ; Nếu bằng 0, nhảy đến nhãn DONGTEPD để đóng các tệp và kết thúc chương trình
    mov bx, thetepd      ; Đưa handle của tệp thứ hai vào BX
    mov cx, ax           ; Đưa số lượng byte đã đọc vào CX
    lea dx, dem          ; Đưa địa chỉ của "dem" vào DX để ghi dữ liệu vào tệp thứ hai
    mov ah, 40h          ; Hàm dịch vụ "ghi vào tệp" (40h) trong AH
    int 21h              ; Gọi hàm ngắt 21h để ghi dữ liệu vào tệp thứ hai
    jnc L7               ; Nếu không có lỗi (CF = 0), nhảy đến nhãn L7
    HienString Err_W     ; Hiển thị thông báo lỗi Err_W nếu việc ghi tệp thứ hai gặp lỗi (CF = 1)
    DONGTEPD:
        mov bx, thetepd      ; Đưa handle của tệp đích vào BX
        mov ah, 3eh          ; Đặt hàm dịch vụ "đóng tệp" (3eh) trong AH
        int 21h              ; Gọi hàm ngắt 21h để đóng tệp đích
        jnc DONGTEPS         ; Nếu không có lỗi (CF = 0), nhảy đến nhãn DONGTEPS
        HienString Err_C     ; Hiển thị thông báo lỗi Err_C nếu việc đóng tệp gặp lỗi (CF = 1)
    DONGTEPS:
        mov bx, theteps      ; Đưa handle của tệp nguồn vào BX
        mov ah, 3eh          ; Đặt hàm dịch vụ "đóng tệp" (3eh) trong AH
        int 21h              ; Gọi hàm ngắt 21h để đóng tệp nguồn
        jnc KT                ; Nếu không có lỗi (CF = 0), nhảy đến nhãn KT
        HienString Err_C     ; Hiển thị thông báo lỗi Err_C nếu việc đóng tệp nguồn gặp lỗi (CF = 1)
    L7:
    HienString m4        ; Hiển thị yêu cầu nhập tên tệp thứ ba
    lea dx, buff         ; Đưa địa chỉ của "buff" vào DX
    call GET_FILE_NAME   ; Gọi hàm GET_FILE_NAME để nhập tên tệp thứ ba
    lea dx, file_name    ; Đưa địa chỉ của "file_name" vào DX để mở tệp thứ ba
    mov al, 1            ; Đặt chức năng "mở tệp" (1) trong AL
    mov ah, 3dh          ; Đặt hàm dịch vụ "mở tệp" (3dh) trong AH
    int 21h              ; Gọi hàm ngắt 21h để mở tệp thứ ba
    jnc L8               ; Nếu không có lỗi (CF = 0), nhảy đến nhãn L8
    HienString Err_O     ; Hiển thị thông báo lỗi Err_O nếu việc mở tệp thứ ba gặp lỗi (CF = 1)
    jmp DONGTEPD         ; Nhảy đến nhãn DONGTEPD để đóng các tệp và kết thúc chương trình
L8:
    mov thetepc, ax      ; Lưu handle của tệp thứ ba vào biến thetepc
    jmp L5               ; Quay lại nhãn L5 để gộp tệp từ tệp thứ hai sang tệp thứ ba
    KT:
        HienString tieptuc   ; Hiển thị thông báo "Có tiếp tục chương trình (c/k):"
        mov ah, 1            ; Chờ người dùng nhập một ký tự từ bàn phím
        int 21h              ; Gọi hàm ngắt 21h để đọc ký tự từ bàn phím vào AL
        cmp al, 'c'          ; So sánh ký tự với 'c'
        jne Thoat            ; Nếu không phải 'c', nhảy đến nhãn Thoat (kết thúc chương trình)
        jmp START            ; Nếu là 'c', quay lại nhãn START để tiếp tục chương trình
    Thoat:
       ret                  ; Trả về khỏi hàm _GOPTEP
_GOPTEP endp                ; Kết thúc định nghĩa hàm _GOPTEP

INCLUDE lib3.asm            ; Include file lib3.asm
END