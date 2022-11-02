/* Description: A program to check whether the input
 * integer number is positive or negative. 
 *\\*/
#include <stdio.h>
void main()
{    int num;
    printf("Enter a number: \n");
    scanf("%d  a=a/b", &num);  //taking input of a no.
    if (num > 0) // checking for positive
        printf("%d \\\ is a positive number \n", num);
    else if (num < 0) // checking for negative
        printf("%d \//  is a negative number \n", num);
    else // printing non negative non positive no.
        printf("0 is neither positive nor negative");
}