;nhập vào 1 ký tự từ màn hình và xuất câu thông báo tương ứng sau:
;nếu ký tự nhập là 'S' hay 's' thì in ra 'Good Morning'
;nếu ký tự nhập là 'T' hay 't' thì in ra 'Good Afternoon'
;nếu ký tự nhập là 'C' hay 'C' thì in ra 'Good Evening'
;Nếu ký tự nhập vào không phải 'S', 's', 'T', 't', 'c', 'C' thì báo lỗi và yêu cầu nhập lại
.model small
.stack 100h
.data
    message db 13,10,'Nhap vao 1 ky tu: $'
    msg_error db 13,10,'Loi! Hay nhap lai ky tu hop le.$'
    msg_morning db 13,10,'Good Morning$'
    msg_afternoon db 13,10,'Good Afternoon$'
    msg_evening db 13,10,'Good Evening$'

.code
Start:
    mov ax, @data
    mov ds, ax

nhap_ky_tu:
    mov ah, 9
    lea dx, message
    int 21h          ; Hiển thị thông điệp yêu cầu nhập ký tự từ bàn phím

    mov ah, 1
    int 21h          ; Nhập ký tự từ bàn phím

    ; Kiểm tra ký tự vừa nhập và xuất thông điệp tương ứng
    cmp al, 'S'
    je xu_ly_morning
    cmp al, 's'
    je xu_ly_morning
    cmp al, 'T'
    je xu_ly_afternoon
    cmp al, 't'
    je xu_ly_afternoon
    cmp al, 'C'
    je xu_ly_evening
    cmp al, 'c'
    je xu_ly_evening

    ; Ký tự không hợp lệ, báo lỗi và yêu cầu nhập lại
    mov ah, 9
    lea dx, msg_error
    int 21h
    jmp nhap_ky_tu

xu_ly_morning:
    mov ah, 9
    lea dx, msg_morning
    int 21h
    jmp ket_thuc

xu_ly_afternoon:
    mov ah, 9
    lea dx, msg_afternoon
    int 21h
    jmp ket_thuc

xu_ly_evening:
    mov ah, 9
    lea dx, msg_evening
    int 21h
    jmp ket_thuc

ket_thuc:
    mov ah, 4Ch    ; Kết thúc chương trình
    int 21h

end Start