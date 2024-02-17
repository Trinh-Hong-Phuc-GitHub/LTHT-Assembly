.MODEL SMALL
.STACK 100H

.DATA
    array DB 10 DUP(?)  ; Mảng chứa dãy số nguyên
    msg1 DB "Nhap vao 10 so nguyen:", "$"
    msg2 DB "So nho nhat: ", "$"
    msg3 DB "So nho thu hai: ", "$"

.CODE
MAIN PROC
    MOV AX, @DATA        ; Khởi tạo data segment
    MOV DS, AX

    ; In thông điệp nhập dãy số
    MOV AH, 09H
    LEA DX, msg1
    INT 21H

    ; Nhập dãy số từ bàn phím
    MOV CX, 10            ; Số lần nhập (10 số nguyên)
    MOV SI, 0             ; Khởi tạo index mảng
INPUT_LOOP:
    MOV AH, 01H           ; Đọc 1 ký tự từ bàn phím
    INT 21H
    SUB AL, 30H           ; Chuyển ký tự số thành giá trị số nguyên
    MOV array[SI], AL     ; Lưu giá trị vào mảng
    INC SI                ; Tăng index
    LOOP INPUT_LOOP        ; Lặp lại cho đến khi nhập đủ 10 số

    ; Tìm số bé nhất và số bé nhì trong dãy số
    MOV CL, 10            ; Số lần so sánh
    MOV BL, 0FFH          ; Giả định số bé nhất là lớn nhất (255)
    MOV BH, 0FFH          ; Giả định số bé nhì cũng lớn nhất
    LEA SI, array         ; Đưa con trỏ về đầu mảng
FIND_MIN:
    MOV AL, [SI]          ; Lấy giá trị từ mảng
    CMP AL, BL            ; So sánh với số bé nhất hiện tại
    JGE CHECK_SECOND_MIN  ; Nếu lớn hơn hoặc bằng, kiểm tra số bé nhì
    MOV BH, BL            ; Số bé nhì trở thành số bé nhất
    MOV BL, AL            ; Cập nhật số bé nhất mới
    JMP NEXT_ITERATION    ; Bỏ qua việc kiểm tra số bé nhì
CHECK_SECOND_MIN:
    CMP AL, BH            ; So sánh với số bé nhì
    JGE NEXT_ITERATION    ; Nếu lớn hơn hoặc bằng, không cần cập nhật
    MOV BH, AL            ; Cập nhật số bé nhì mới
NEXT_ITERATION:
    INC SI                ; Di chuyển đến phần tử tiếp theo trong mảng
    LOOP FIND_MIN         ; Lặp lại cho đến khi so sánh với tất cả các phần tử

    ; In số bé nhất và số bé nhì ra màn hình
    MOV AH, 09H
    LEA DX, msg2
    INT 21H
    MOV DL, BL            ; In số bé nhất
    ADD DL, 30H           ; Chuyển số thành ký tự
    MOV AH, 02H
    INT 21H

    MOV AH, 09H
    LEA DX, msg3
    INT 21H
    MOV DL, BH            ; In số bé nhì
    ADD DL, 30H           ; Chuyển số thành ký tự
    MOV AH, 02H
    INT 21H

    MOV AH, 4CH           ; Kết thúc chương trình
    INT 21H
MAIN ENDP

END MAIN