#!/bin/bash

#XXXXXX-------XXXXXXXXXX--------XXXXXXXXXXXX--------XXXXXXXXXXXX----------XXXXXXXXXXXXX---------XXXXXXXXX---------
#Name-Trishit Kundu Roll-1928327

#Algorithm && Program Description:-

# This is a program to get the longest word in a file. 
# Here we are reading the file character by character and storing them in a variable until it encounters with 
# space or any special characters or escape sequence to form a word. Then it is being compared to the 
# maxlength of the word if length of the current word is greater than maxlength it swaps to maxlength. 
# Then the longest word is formed. Taking the length of the longest word we are checking again in the file
# whether same length words are available or not. At the end we will get those words which are longest words. 

#XXXXXXX-------XXXXXXXXXX--------XXXXXXXXXXXX--------XXXXXXXXXXXX----------XXXXXXXXXXXXX---------XXXXXXXXX---------

length=0
max_length=0
longword=''
filename=$1
while read -rN1 p ; do
    if [[ $p == ' ' || $p == ',' || $p == $'\n' || $p == '.' || $p == '/' || $p == "'" || $p == ';' || $p == ':' || $p == '\' || $p == ']'|| $p == '['|| $p == '{' || $p == '}' || $p == '=' || $p == '-' || $p == '%' ]]; then
       #checking for special characters
        if [ $length -gt $max_length ]; then
            max_length=$length              # checking for maxlength words
        fi
        length=0
        longword=''
    else
        longword+="$p"              #storing character by character until word is formed without special characters
        ((length+=1))
    fi
done < $filename                

if [ $length -gt $max_length ]; then        #checking the length of longest word
    max_length=$length
fi

while read -rN1 p ; do
    if [[ $p == ' ' || $p == ',' || $p == $'\n' || $p == '.' || $p == '/' || $p == "'" || $p == ';' || $p == ':' || $p == '\' || $p == ']'|| $p == '['|| $p == '{' || $p == '}' || $p == '=' || $p == '-' || $p == '%' ]]; then
        if [ $length -eq $max_length ]; then
            echo $longword                  #checking the length of longest word in the file to get same length words
        fi
        length=0
        longword=''
    else
        longword+="$p"
        ((length+=1))
    fi
done < $filename
if [ $length -eq $max_length ]; then        #printing the same length longest words.
    echo $longword
fi