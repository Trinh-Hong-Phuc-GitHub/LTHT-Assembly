; in chuỗi đỏa ngược:
.model small
.stack 100
.data 
    tb db 10, 13, 'Vui long nhap chuoi: $' 
    nhap DB 50 dup('$') ; Chuỗi gồm 50 byte chứa 50 giá trị khởi đầu 
    tb1 db 10, 13, 'Chuoi da duoc dao nguoc: $' 

.code
main proc
    mov ax, @data
    mov ds, ax ; Khởi tạo thanh ghi ds

    ; In chuỗi tb1 ra màn hình
    lea dx, tb
    mov ah, 9
    int 21h

    ; Nhập xâu kí tự 
    lea dx, nhap
    mov ah, 0Ah ; 0Ah là hàm nhập chuỗi
    int 21h 
 
    ; In chuỗi tb1 ra màn hình
    lea dx, tb1
    mov ah, 9
    int 21h

    ; Đảo ngược chuỗi
    mov cl, [nhap + 1] ; Chuyển độ dài chuỗi vừa nhập vào cl
    lea si, [nhap + 2] ; Dưa si chỉ về phần tử thứ 2 của mảng là ký tự đầu tiên được nhập vào

    ; Đẩy các ký tự vào ngăn xếp
    Lap:
        push [si] ; Đưa phần tử mà si đang chỉ đến vào đầu ngăn xếp
        inc si ; Tăng giá trị của si lên 1 
        loop Lap

    ; Lấy dữ liệu từ ngăn xếp và in ra màn hình
    mov cl, [nhap + 1] ; Chuyển độ dài chuỗi vừa nhập vào cl
    Lap2:
        ; Lấy giá trị từ đỉnh ngăn xếp
        pop dx ; Lấy giá trị trên đỉnh ngăn xếp đưa vào dx
        mov ah, 2 ; Hàm in ký tự
        int 21h
        loop Lap2

    ; Trở về DOS dùng hàm 4CH của INT 21H
    MOV AH, 4CH
    INT 21H
main endp
end