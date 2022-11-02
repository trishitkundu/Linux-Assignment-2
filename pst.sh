#!/bin/bash

#XXXXXX-------XXXXXXXXXX--------XXXXXXXXXXXX--------XXXXXXXXXXXX----------XXXXXXXXXXXXX---------XXXXXXXXX---------
#Name-Trishit Kundu Roll-1928327

#Algorithm
# This is the program to print output of processes. 
# We read data from /proc and store it in a file.Then We are extracting the process numbers irrespective of their pids and ppids 
# and store it in another text file.Now we are declaring two arrays. and save the pid values and ppid valuues in respective arrays.
# We run two loops first loop iterates the pid array and for each pid value the inner loop will iterate all ppid values.When the ppid
#matches with pid value that means the child process of respective pid then we are printing them as child of the parent process.
#now as we get the child process we are iterating for that child process and so on goes until we are printing the whole child family.
# as form of tree.  
#                                (This is tree is somewhat like pstree but not exact of it.)
#XXXXXXX-------XXXXXXXXXX--------XXXXXXXXXXXX--------XXXXXXXXXXXX----------XXXXXXXXXXXXX---------XXXXXXXXX---------


ls /proc > q1_pid.txt  #getting list of folders in /proc folder
grep -E '^[0-9]' q1_pid.txt >q1_output.txt  #extracting only the folder with numaric value(i.e. processes)
while read -r line
do
pi_d=$line
parpid=$(awk '/PPid:/{print $2}' /proc/$pi_d/status) #getting the ppid of each processes
printf "$parpid\n" 
done < q1_output.txt > q1_pp.txt 2> q1_error.txt #redirecting the outputs
declare -a pid   #declaring two arrays for pids and ppids
declare -a ppid
i=0
while read -r line 
do
pid[i]=$line   #inserting pid values in pid arrays
((i++))
done < q1_output.txt
j=0
    while read -r pi 
    do
    ppid[j]=$pi         #inserting ppid values in ppid arrays
    ((j++))
    done < q1_pp.txt

 #printing in terminal 

for (( i=0; i<${#pid[@]};i++ ))   #for length of pid running the outer loop
do
    k=${pid[$i]}              #Assigning the pid values in the varriable.
    ps -p $k -o comm=         #printing name of the process for respective pid
    printf "\t%s" "----"
    if [[ $k == 1 ]]          #If root process
    then
    printf " "
    elif [[ $k == 2 ]]      
     then
       printf "         "
       fi
    for (( j=0; j<${#ppid[@]};j++ ))      #Inner loop traversing the whole ppid array.
     do  
        if [[ $k == ${ppid[$j]} ]]       #if pid of outer loop matching the ppid of any inner loop
        then 
          printf "\t%s" "|----"
          ps -p ${pid[$j]} -o comm=       #printing the child process name through pid of respective ppid of inner loop.
          k=${pid[$j]}        #for searching further child
        fi
     done
done 
printf "\n"