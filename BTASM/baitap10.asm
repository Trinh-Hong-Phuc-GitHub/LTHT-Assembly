.model small
.stack 100h
.data
    msg1 db 13,10,'Nhap so chia (so nguyen): $'
    msg2 db 13,10,'Nhap so bi chia (so nguyen): $'
    msg3 db 13,10,'Nhap so chu so sau dau phay: $'
    result_msg db 13,10,'Ket qua: $'
    buffer db 255 dup('$') ; Bộ đệm cho việc lưu kết quả

.code
Start:
    mov ax, @data
    mov ds, ax

    ; Hiển thị thông báo yêu cầu nhập số chia
    mov ah, 9
    lea dx, msg1
    int 21h

    ; Nhập số chia
    call nhap_so_nguyen

    ; Hiển thị thông báo yêu cầu nhập số bị chia
    mov ah, 9
    lea dx, msg2
    int 21h

    ; Nhập số bị chia
    call nhap_so_nguyen

    ; Hiển thị thông báo yêu cầu nhập số chữ số sau dấu phẩy
    mov ah, 9
    lea dx, msg3
    int 21h

    ; Nhập số chữ số sau dấu phẩy
    call nhap_so_nguyen

    ; Chuyển đổi số chia và số bị chia thành số thực
    mov ax, so_bi_chia
    mov bx, 10000 ; Dịch chuyển số nguyên thành số thực (ví dụ: 3 -> 3.0000)
    mul bx
    mov so_bi_chia, ax

    ; Tính toán kết quả
    xor ax, ax
    mov cx, so_chu_so_sau_dau_phoi ; Số chữ số sau dấu phẩy
tinh_toan:
    add ax, so_chia
    loop tinh_toan

    ; Chuyển kết quả thành chuỗi
    mov si, offset buffer
    mov bx, 10 ; Để chia số thực thành từng chữ số
xu_ly_sau_dau_phoi:
    xor dx, dx
    div bx
    add dl, '0' ; Chuyển số dư thành ký tự
    dec si
    mov [si], dl ; Lưu ký tự vào buffer
    loop xu_ly_sau_dau_phoi

    ; Hiển thị kết quả
    mov ah, 9
    lea dx, result_msg
    int 21h

    mov dx, offset buffer ; Đưa con trỏ tới vùng nhớ chứa chuỗi kết quả
hien_thi_ket_qua:
    mov dl, [dx]
    mov ah, 2
    int 21h
    inc dx
    cmp byte ptr [dx], '$' ; Kiểm tra kết thúc chuỗi
    jne hien_thi_ket_qua

    mov ah, 4Ch ; Kết thúc chương trình
    int 21h

nhap_so_nguyen proc
    xor ax, ax
    xor dx, dx

nhap_so_nguyen_nhap:
    mov ah, 1
    int 21h
    cmp al, 13 ; Kiểm tra Enter để kết thúc việc nhập
    je nhap_so_nguyen_ket_thuc

    cmp al, '0'
    jl nhap_so_nguyen_nhap ; Đảm bảo chỉ nhập số dương

    cmp al, '9'
    jg nhap_so_nguyen_nhap ; Đảm bảo chỉ nhập số nguyên

    sub al, '0' ; Chuyển ký tự số sang giá trị số
    mov ah, 0
    mov dl, 10
    mul dl ; Nhân số cũ lên 10 để thêm số mới vào cuối
    add ax, dx ; Thêm số mới vào
    mov dx, ax

    jmp nhap_so_nguyen_nhap

nhap_so_nguyen_ket_thuc:
    mov so_chia, dx ; Lưu giá trị vào biến
    ret
nhap_so_nguyen endp

.data
    so_chia dw ?
    so_bi_chia dw ?
    so_chu_so_sau_dau_phoi dw ?

end Start