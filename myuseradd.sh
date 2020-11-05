#! /bin/bash
#
# Author: Coty Fivecoat
#

# For Stage 1
# Use this function to print out the help message for -h
# or if the user does not provide a valid argument.
#
function print_usage () {
	echo "Usage: myuseradd.sh -a <login> <passwd> <shell> - add a user account
 	myuseradd.sh -d <login>  - remove a user account
 	myuseradd.sh -h          - display this usage message"
	#
	# Add your implementation of print_usage here
	#
}



# For Stage 2:
# Use this function to delete users as described in the
# assignment instructions.
# 
# Arguments : userToDelete
#
function delete_user () {
	echo "delete_user"
	NUM_RESULTS=`getent passwd | grep "$1" | wc -l`
	if [ $NUM_RESULTS > 0 ]
	then
		if [ "$1" != 'root' ]
			then 
				userdel -r "$1" 2>/dev/null
				echo "$1" "is deleted"
		fi   
	else
		echo "ERROR: " "$1" " does not exist"
	fi
}



# For Stage 3:
# Use this function to add users as described in the
# assignment instructions
#
# Arguments : userToAdd, userPassword, shell
# 
function add_user () {
	echo "add_user"
	if [ getent passwd | grep "$1" | wc -l < 1 ]
	then 
		useradd -m "$1" -s "$3" && echo "$1":"$2" | chpasswd && echo "$1" "(" "$2" ")with " "$3" "is added"
	else
		echo "ERROR: " "$1" "exists"
	fi
}



# For Stage1:
# Use this function to parse the command line arguments
# provided to this script to determine which function
# to call.  Example, if -h is used, print_usage
#
function parse_command_options () {

# This is just pseudo code.  Look at the BASH Script
# tips document for an example of how to use case in BASH
	case "$1" in
	-h)
		print_usage
	;;
	-d)
		delete_user "$2"
	;;
	-a)
		add_user "$2" "$3" "$4"
	;;
	*)
		echo "ERROR: Invalid option: $1" 
		print_usage
	;;

esac
}


#
# This will run and call the parse_command_options function
# and pass all of the arguments to that function
#
parse_command_options "$@"

