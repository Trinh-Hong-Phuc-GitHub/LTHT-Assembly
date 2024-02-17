; Tổng các chữ số nhưng có vấn đề
.model small
.stack 100h
.data
    msg db 13,10,'Nhap vao so: $'
    result_msg db 13,10,'Tong cac chu so cua so da nhap la: $'

.code
Start:
    mov ax, @data
    mov ds, ax

    ; Hiển thị thông báo yêu cầu nhập số
    mov ah, 9
    lea dx, msg
    int 21h

    ; Chuẩn bị thanh ghi để tính tổng
    xor cx, cx ; Đặt CX = 0 để tính tổng
    xor dx, dx ; Đặt DX = 0 để lưu giá trị của chữ số hiện tại

    ; Nhập số từ bàn phím
nhap_so:
    mov ah, 1
    int 21h
    cmp al, 13 ; Kiểm tra Enter để kết thúc việc nhập
    je tinh_tong

    sub al, '0' ; Chuyển ký tự số sang giá trị số
    add cx, ax  ; Cộng giá trị số vào tổng
    mov dl, al  ; Lưu giá trị của chữ số hiện tại vào DX

    ; Kiểm tra xem chữ số hiện tại có bằng 0 hay không
    cmp dx, 0
    je nhap_so ; Nếu bằng 0 thì bỏ qua

    jmp nhap_so ; Nhập tiếp ký tự tiếp theo

tinh_tong:
    ; Hiển thị tổng các chữ số của số đã nhập
    mov ah, 9
    lea dx, result_msg
    int 21h

    ; Chuyển tổng sang ký tự và hiển thị ra màn hình
    mov ah, 2
    mov dl, cl
    add dl, '0' ; Chuyển tổng sang ký tự
    int 21h

    mov ah, 4Ch ; Kết thúc chương trình
    int 21h

end Start