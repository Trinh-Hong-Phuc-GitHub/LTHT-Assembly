; Nhập vào 1 ký tự, cho biết ký tự kế trước và kế sau
.model small
.stack 100h
.data
    message db 13,10, 'Hay go 1 phim: $'
    char db 0            ; Ký tự nhập từ bàn phím
    prev_char db 0       ; Ký tự kế trước
    next_char db 0       ; Ký tự kế sau
    msg_prev db 13,10,'Ky tu ke truoc: $'
    msg_next db 13,10,'Ky tu ke sau: $'

.code
Start:
    mov ax, @data
    mov ds, ax

    ; Hiển thị thông điệp yêu cầu nhập ký tự từ bàn phím
    mov ah, 9
    lea dx, message
    int 21h

    ; Nhập ký tự từ bàn phím
    mov ah, 1
    int 21h
    mov char, al          ; Lưu ký tự vừa nhập vào char

    ; Tính ký tự kế trước
    mov dl, char
    sub dl, 1
    mov prev_char, dl

    ; Tính ký tự kế sau
    mov dl, char
    add dl, 1
    mov next_char, dl

    ; In ký tự kế trước
    mov ah, 9
    lea dx, msg_prev
    int 21h

    mov dl, prev_char
    mov ah, 2
    int 21h

    ; In ký tự kế sau
    mov ah, 9
    lea dx, msg_next
    int 21h

    mov dl, next_char
    mov ah, 2
    int 21h

    mov ah, 4Ch  ; Kết thúc chương trình
    int 21h

end Start