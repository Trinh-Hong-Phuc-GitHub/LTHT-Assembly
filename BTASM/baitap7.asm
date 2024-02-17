.model small
.stack 100h
.data
    msg1 db 13, 10, 'Nhap chuoi ky tu: $'
    msg2 db 13, 10, 'Nhap ky tu: $'
    msg_found db 13, 10, 'Co ky tu trong chuoi$'
    msg_not_found db 13, 10, 'Khong co ky tu trong chuoi$'

    buffer db 50, '$'  ; Chuỗi ký tự
    char db 0          ; Ký tự cần kiểm tra
    found db 0         ; Cờ chỉ trạng thái tìm thấy

.code
Start:
    mov ax, @data
    mov ds, ax
    mov es, ax

    ; Nhập chuỗi ký tự từ bàn phím
    mov ah, 9
    lea dx, msg1
    int 21h

    mov ah, 0Ah  ; Đọc chuỗi từ bàn phím
    lea dx, buffer
    int 21h

    ; Nhập ký tự từ bàn phím
    mov ah, 9
    lea dx, msg2
    int 21h

    mov ah, 1    ; Đọc ký tự từ bàn phím
    int 21h
    mov char, al ; Lưu ký tự cần kiểm tra

    ; Kiểm tra xem ký tự có nằm trong chuỗi hay không
    mov si, offset buffer

kiem_tra_ky_tu:
    mov al, [si]   ; Load ký tự từ chuỗi vào AL
    cmp al, '$'    ; Kiểm tra kết thúc chuỗi
    je ket_thuc

    cmp al, char   ; So sánh ký tự với ký tự cần tìm
    je tim_thay

    inc si
    jmp kiem_tra_ky_tu

tim_thay:
    mov found, 1   ; Đặt cờ tìm thấy thành 1
    jmp ket_thuc

ket_thuc:
    ; In thông báo dựa vào trạng thái tìm thấy
    mov ah, 9
    cmp found, 1
    je found_label
    lea dx, msg_not_found
    jmp print_message

found_label:
    lea dx, msg_found

print_message:
    int 21h

    mov ah, 4Ch  ; Kết thúc chương trình
    int 21h

end Start