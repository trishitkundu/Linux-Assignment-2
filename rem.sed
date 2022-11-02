#!/bin/bash

#XXXXXX-------XXXXXXXXXX--------XXXXXXXXXXXX--------XXXXXXXXXXXX----------XXXXXXXXXXXXX---------XXXXXXXXX---------
#Name-Trishit Kundu Roll-1928327

#Algorithm && Program Description:-

# It is a sed script to remove the comments from a c file. 
# Here we are using several regex, loops to check comments in the c file where it is getting 
# single line comment i.e (//) and multiline comments i.e.(/* for starting and ending at */).  
# Now for * it is again running sed script and taking we are again running the loop of internediate loop.
# first special character (/, ", ').  It went exactly a character at a time, hence the greater speed of this one.
# We have to build the line in hold space are entirely.

#XXXXXXX-------XXXXXXXXXX--------XXXXXXXXXXXX--------XXXXXXXXXXXX----------XXXXXXXXXXXXX---------XXXXXXXXX---------

:loop           #loop begins

/^\/\// s,.*,,          #checking the start of single comment (/) or multiline comment(/*)
 
/^$/{                   #taking input characterwise from the file
  x                     #Exchange the content between patten space and hold space.  
  p                     
  n
  b loop
}
/^"/{                   #checking for "" to print all characters
  :double
  /^$/{
    x
    p                       #Print the first embedded line or all content in the pattern space.
    n                       #Append/read next line from the input
    /^"/b break
    b double
  }
 
  H                             #Append/copy the data from pattern space to hold space.
  x
  s,\n\(.[^\"]*\).*,\1,         
  x
  s,.[^\"]*,,
 
  /^"/b break                   
  /^\\/{
    H
    x
    s,\n\(.\).*,\1,                 #Find and replace
    x
    s/.//
  }
  b double                          #single comments ends
}
 
/^'/{
  :single
  /^$/{
    x
    p
    n
    /^'/b break         
    b single
  }
  H
  x
  s,\n\(.[^\']*\).*,\1,
  x
  s,.[^\']*,,
 
  /^'/b break
  /^\\/{
    H
    x
    s,\n\(.\).*,\1,
    x
    s/.//
  }
  b single
}
 
/^\/\*/{
  s/.//
  :ccom
  s,^.[^*]*,,
  /^$/ n
  /^\*\//{                  #multiline comment ends
    s/..//
    b loop
  }
  b ccom
}
 
:break
H
x
s,\n\(.[^"'/]*\).*,\1,          #multiline comments ends
x
s/.[^"'/]*//                    
b loop