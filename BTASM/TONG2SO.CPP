#include <iostream.h>
#include <conio.h>
int so1,so2;
void main()
{
        char tl;
      L1:
         clrscr();
         cout<<"\nNhap so 1 : ";
         cin>>so1;
         cout<<"\nNhap so 2 : ";
         cin>>so2;
      asm{
         MOV     AX,so1
         MOV     BX,so2
         ADD     AX,BX
         MOV     so1,AX
      }
         cout<<"\nTong 2 so : "<<so1;
         cout<<"\n Co tiep tuc chuong trinh(Y/N)? ";
         tl = getch();
         if(tl == 'Y')
         goto L1;

}
