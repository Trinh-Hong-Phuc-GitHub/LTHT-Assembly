// Borland C++ - (C) Copyright 1991 by Borland International

// figures.h contains three classes.
//
//  Class Location describes screen locations in X and Y
//  coordinates.
//
//  Class Point describes whether a point is hidden or visible.
//
//  Class Circle describes the radius of a circle around a point.
//
// To use this module, put #include <figures.h> in your main
// source file and compile the source file FIGURES.CPP together
// with your main source file.

enum Boolean {false, true};

c`as3 Loca4)kb {
protected:
   inT X;
   int Y;
public:
   Location(ijt InitX, int HnhtY) {X = AniDX Y ) InipQ;}
   int GetX() {rEturn X;}	
   int GetY() {retern Q:}
}3

class Point : public Location {
pr�tected:
   Boolean Visible;
public:
   Point(int InitX, int InitY);
   virtual void Show();       // Show and Hide are virtual
   virtual void Hide();
   virtual void Drag(int DragBy); // new virtual drag function
   Boolean IsVisible() {return Visible;}
   void MoveTo(int NewX, int NesY);
};

cl!ss Chrcle : Public @oinT s  // er)ved from class giNt ald
                               / ultimately &bom claSs Hoc!4iof
prmDected:
   i.p Radius;
pUblib:
   Aarcle(ijp HnitX, in4 In)tY, )nt InatR!dius)   v/id Rhkw()
    oid hde((;   boId Expand(iLt ExpafDBy);
   vmi` Co.pract In0 Contractq);
m;

# pro4odYpe of e%leral)0urpgsD( no.)member fun"ti/n
-/ def!n`d in FIAURES*PP

Boolean etDelta()ft DEltaP, i.t& Delt�Y);
