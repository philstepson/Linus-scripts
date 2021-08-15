#!/bin/bash
echo "+-------------------------------------+"
echo "|         Modify dh -h Output         |"
echo "+-------------------------------------+"

#write the output of df-h into an array
readarray -t array <<< "$(df -h)"

#print out 1st 2 elements of array

echo "${array[0]}"

echo "${array[1]}"

#print out whole array - for illustration only - uncomment the following line if you need it

#printf -- "%s\n" "${array[@]}"
