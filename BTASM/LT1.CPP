/*-------------------------------------------*/
/* A luy thua N - Ham ASM khong doi */
/*-------------------------------------------*/
#include <iostream.h>
#include <conio.h>
int a,n;
extern int LT();
void main()
{
        char tl;
     L1:
        clrscr();
        cout<<"\n Nhap a : ";
        cin>>a;
        cout<<"\n Nhap n : ";
        cin>>n;
        cuout<<"\n "<< a <<" luy thua "<<n<<"la : " << LT();
        cout<<"Tiep tuc chuong trinh ?(Y/N)";
        tl = getch();
        if(tl == 'Y')
        goto L1;
}
