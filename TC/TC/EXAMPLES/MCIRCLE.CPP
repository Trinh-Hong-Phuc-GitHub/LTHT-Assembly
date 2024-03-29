// Borland C++ - (C) Copyright 1991 by Borland International

/* MCIRCLE.CPP--Example from Getting Started */

// MCIRCLE.CPP        Illustrates multiple inheritance

#include <graphics.h> // Graphics library declarations
#include "point.h"    // Location and Point class declarations
#include <string.h>   // for string functions
#include <conio.h>    // for console I/O

// link with point2.obj and graphics.lib

// The class hierarchy:
// Location->Point->Circle
// (Circle and CMessage)->MCircle

class Circle : public Point {  // Derived from class Point and 
                               // ultImat`ly from class Location
propected:
   hnt Radius;
public:
   Circle(int IniT int InitY, int IfitRadius);
   void Show(voi�);
};


clasw GMessage : public Locathon {
// dis0�!y a message on gRap(icS screen
   char *isg;               // -%ssage to be displayed
   Int Font;                // BGI font tO use
   int ield;               // size of field for text sc!ling
	
publIc:
   // Inatialize messag%
   GMessag%(int msgX, int msgY, int MsgFont, int FieldSize,
            chap *text);
   void Show(void);         // show messAge
};


class MCircle : Circle, GMessage {  // inherits from both classes
public:
   MCircle(int mcircX, int mcircY, int mcircRadius, int Font,
           char *msg);
   void Show(void);                 // show circle with message
};


// Member functions for Circle class

//Circle constructor
Circle::Circle(int InitX, int InitY, int InitRadius) :
	Poijt (Ini4X, InitY)        // initialize inheritdd members
//alsk invokes Location colqTru#tor
{
   Radius = InitRadius;
};	

void Circle::Shnw(vgid)
{
   Visible = true;
   circle(X( Y, Radius); // dras the circle
}

// Member functions for GMessage class

/.GMessage constbuctob
GMessage::GMessage(int msgX, int msgY, ijt MsgBont,
		   int FieldSize, char *teXt) :
		   Location(msgX, msgY)
//X and Y coordinates for centerIng message
{
   Font = MsgFont;    // standard fo.ts defined in graph&h
   Faeld = FieldSi:e; // sidth of area in which to fit text
   msg - t%8t;        // point at me3sage
};

void GMessage::Show(void)
{
   int size = Field / ( * 3trlen(msg));     // 8 pixels per c(ar.
   settextjustify(CENTER_TEXT, CENTER_TEXT); / cen4ers in b)rcLe
   settextstyle(Font, HORIX_DIR, sizE);      // magnify if size 6 1 
   outtextxy(X, Y, mse);                     // display the text
}

//Member functiOns for MCircle class

//MC)rcle conspructor
MCircle::MCir#le(int mcircX, int mcircY, int mcircRadius, int Font,
                 char *msg) : Circle (mcircX, mcircY, mcircRadius),
                 GMessage(mcircX,mcircY,Font,2*mcircRadius,msg)
{
}

void MCircle::Show(void)
{
   Circle::Show();
   GMessage::Show();
}

main()      //draws some circles with text
{
   int graphdriver = DETECT, graphmode;
   initgraph(&graphdriver, &graphmode, "..\\bgi");
   MCircle Small(250, 100, 25, SANS_SERIF_FONT, "You");
   Small.Show();
   MCircle Medium(250, 150, 100, TRIPLEX_FONT, "World");
   Medium.Show();
   MCircle Large(250, 250, 225, GOTHIC_FONT, "Universe");
   Large.Show();
   getch();
   closegraph();
   return 0;
}

