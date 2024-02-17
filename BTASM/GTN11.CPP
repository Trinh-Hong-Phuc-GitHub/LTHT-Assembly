#include <iostream.h>
#include <conio.h>
extern int GIAITHUA(int i);     /*Ham 1 doi , co gia tri tro ve la int*/
void main()
{
        char tl;
        int  n;
     L1:
        clrscr();
        cout<<"\n Hay vao so n : ";
        cin>>n;
        cout<<"\n Giai thua cua "<<n<<" la : " << GIAITHUA(n);
        cout<<"\n Co tiep tuc chuong trinh ? (Y/N)";
        tl = getch();
        if(tl == 'Y')
        goto L1;
}

