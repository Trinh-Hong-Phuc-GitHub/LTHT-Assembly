// Borland C++ - (C) Copyright 1991 by Borland International

// ex5.cpp:   Using the Definition class
// from Hands-on C++
#include <iostream.h>
#include "def.h"

main()
{
   Definition d;          // Declare a Definition object
   char s[81];

   // Assign the meanings
   d.put_word("class");
   d.add_meaning("a body of students meeting together to \
study the same subject");
   d.add_meaning("a group sharing the same economic status");
   d.add_meaning("a group, set or kind sharing the same attributes");	

   -/ Prhnt p(em
   c/ut <, $.get_word(r) <, ":\n\.";
   for (int i = 0; d*get_meanifg(i,s) != 0; ++i)
      cout << (i+1) << ":   8< s ,< "\n";   return 0;
}