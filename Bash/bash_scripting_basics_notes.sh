#!/bin/bash
# Debug mode
# bash -x ./bash_script_course.sh
# read -p "Some promt" VAR_NAME (Will take input on the same line as promt)
# read -s (Take use input silently/input will not be shown while typing)
# iconv (Command used to encode texts using UTF8 or UTF16)
# base64/base64 -d


echo "Hello World" > file.txt
echo "New Line" >> file.txt

# START OF MULTI-LINE COMMENT
: '
m
u
l
t
i
line
comment

-d (Check if directory exists)
-e (Check if file exists)

# Heredoc
cat << heredoc
Testing heredoc
Testing heredoc
heredoc


# If-Else statement
# Can use [] or (()) with If-Else-Elif statements
# See Example
count=60
if [[ $count -ne 60 || $count -gt 70 ]]
then
	echo "condition is true"
elif (( $count >= 60 )) && (( $count <= 60 ))
then
	echo "count is greater and less than equal to 60"
else
	echo "condition is false"
fi

# While loop
number=50
while [ $number -lt 70 ]
do
	echo "Incremeneting"
	number=$(( number+1 ))
	echo "Incremented"
done

# Until loop
new_num=10
until (( $new_num == 8 )) 
do
	echo "Decrementing"
	new_num=$(( new_num-1 ))
	echo "Decremented"
done

# For loop
# with break/stop the for loop
for i in {1..6..2} # Range 1-6 with increment of 2
do
	if [[ $i == 3 && $i < 4 ]]
	then
		break
	fi
	echo $i
done

# Program Argument
program_arguments=("$@")
echo ${program_arguments[0]} ${program_arguments[1]} ${program_arguments[2]}
echo $@
echo "There are" $# "arguments"

# Reading files from STDIN and output contents of that file to STDOUT
while read line
do
	echo "$line"
done < "${1:-/dev/stdin}"

# Redirecting STDOUT to good_output.txt STDERR to bad_output.txt
ls -al 1>good_output.txt 2>bad_output.txt

# Sending data from this script to bash_script_course2.sh
TEST='testing'
export TEST
./bash_script_course2.sh


# Comparing strings input
# String manipulation
echo "Enter first string"
read str1

echo "Enter second string"
read str2

if [ "$str1" == "$str2" ]
then
	echo "Strings match"
else
	echo "Strings dont match"
fi
# Concatinate
concat=$str1$str2
# Uppercase
echo $concat
echo ${concat^^}

# Arithmetic Operations with decimals and hexadecimals
# Arithmetic Operators are the same
echo $(( 50 + 1 ))

num1=50
num2=1
echo $(expr $num1 + $num2 )
echo $(expr $num1 \* $num2 )

# Hex --> Decimal
hex=FFFF
echo "obase=10; ibase=16; $hex" | bc

# Arrays
nums=(1 2 3 4 5)
strings=("test1" "test2" "test3" "test4")

echo "${nums[@]}"
# Show indices
echo "Indices: ${!nums[@]}"
# Show length of Array
echo "Length: ${#nums[@]}"

unset nums[2]
echo "Indices: ${!nums[@]}"
echo "Length: ${#nums[@]}"
echo "${nums[@]}"

echo "${strings[@]}"

# Functions
function my_func() {
	echo "Testing function"
}

function print_arg() {
	echo $1
}

my_func
print_arg ARGUMENT

# File/Directory operations
# Check if directory exists
echo "Enter directory name to check"
read direct_name

if [ -d "$direct_name" ]
then 
	echo "$direct_name Exists"
else
	echo "$direct_name Does not exist"
fi

# Check if file exists
echo "Enter file name to check"
read file_name
if [ -f "$file_name" ]
then
	echo "$file_name Exists"
	
	# Appending to the file
	read append_text
	echo "$append_text" >> "$file_name"

	# Reading file content
	while IFS= read -r line
	do
		echo "$line"
	done < $file_name
else
	echo "$file_name Does not exists"
fi


# Downloading files using cURL
url="http://ovh.net/files/1Mio.dat"

# Download file and inhert the name
# curl ${url} -O

# New file name
# curl ${url} -o new_file_name

# Check header of the file
curl -I ${url}

# Creating an interactive menu
select car in BMW TESLA HONDA MERCEDES
do
	case $car in 
	BMW)
		echo "BMW SELECTED";;
	TESLA)
		echo "TESLA SELECTED";;
	HONDA)
		echo "HONDA SELECTED";;
	MERCEDES)
		echo "MERCEDES SELECTED";;
	*)
		echo "ERROR! Please select choices between 1..5";;
	esac
done

# Use inotify to monitor filesystem.
# First install inotify
# inotifywait -m /name/of/directory/monitored

# Use grep in script to search for a word in a given file.
echo "Enter name of file to be searched"
read file_name

if [ -f $file_name ]
then
	echo "Enter search pattern"
	read search_pattern
	grep -i $search_pattern $file_name
else
	echo "$file_name does not exists"
fi

# Using awk to print content of file in a specific format
echo "Enter name of file for awk testing"
read file_name

if [ -f $file_name ]
then
	# Print contents of file_name
	# awk '{print}' $file_name

	# Print lines containing the word Hello
	# awk '/Hello/ {print}' $file_name

	# Print fields 1 and 9
	awk '{print $1,$2}' $file_name	
else
        echo "$file_name does not exists"
fi

# Using sed to modify file contents
echo "Enter name of file for sed testing"
read file_name

if [ -f $file_name ]
then
	# Replacing all l to L in file_name and output results to sed_test.txt
	sed 's/l/L/g' $file_name > sed_test.txt
else
        echo "$file_name does not exists"
fi

# Creating directory
declare -l DIR
# Prompt will on the same line
echo -n "Enter a directory to create: "
read DIR

if [[ -e $DIR ]]
then
	echo "$DIR already exists"
	exit 1
elif [[ -w $PWD ]]
then
	mkdir $DIR
else
	echo "You have no permissions to $PWD"
	exit 2
fi

# Identify file types in current directory
for file in $(ls)
do
	if [[ -d $file ]]
	then
		continue
	fi
	stat -c "%n %F" $file
done

# Listing all files in the current directory using foreach loop.
foreach f (*)
	echo $f
end


# END OF MULTI-LINE COMMENT
'