; nhập vào 1 ký tự, nếu không phải số thì báo lỗi, là số thì hiện
.MODEL SMALL
.STACK 100h
.DATA
    MoiNhap DB 13,10, 'Nhap mot ky tu so n = $'
    KoLaChuSo DB 13,10, 'Ko phai , hay nhap lai $'
    LaChuSo DB 13,10, 'Dung roi, so vua nhap la $'
.CODE
    MOV AX, @Data       ; Dua cac du lieu
    MOV DS, AX          ; Vao phan doan du lieu

NhapKyTu:
    MOV DX, OFFSET MoiNhap  ; Xuat mot chuoi tro boi DX
    MOV AH, 9               ; Bang chuc nang thu 9
    INT 21h                 ; Cua ngat 21h DOS

    MOV AH, 1               ; Nhap mot ky tu vao AL
    INT 21h                 ; Bang chuc nang 1 cua ngat 21h DOS

    CMP AL, '0'             ; Kiem tra co phai chu so hay ko
    JGE ChuSo               ; Neu >= '0' thi kiem tra tiep
    JMP KyTuKhac            ; Ngược lại, không phải số

ChuSo:
    CMP AL, '9'             ; Kiểm tra xem ký tự có nằm trong khoảng số không
    JLE LaSo                ; Nếu <= '9' thì là số, xuất kết quả
    JMP KyTuKhac            ; Ngược lại, không phải số

LaSo:
    MOV DX, OFFSET LaChuSo  ; Xuất thông báo đúng là số
    MOV AH, 9               ; Dùng để in chuỗi
    INT 21h                 ; In chuỗi

    MOV DL, AL              ; Đưa ký tự số vào DL để xuất ra màn hình
    MOV AH, 2               ; Xuất ký tự
    INT 21h                 ; In ký tự số

    JMP XuatKyTu            ; Xuất ký tự và kết thúc chương trình

XuatKyTu:
    MOV AH, 4Ch             ; Ket thuc chuong trinh
    INT 21h                 ; Va tra ve DOS bang chuc nang 4Ch

KyTuKhac:
    MOV DX, OFFSET KoLaChuSo  ; Xuất thông báo không phải là số
    MOV AH, 9                 ; Dùng để in chuỗi
    INT 21h                   ; In chuỗi
    JMP NhapKyTu              ; Yêu cầu nhập lại

END