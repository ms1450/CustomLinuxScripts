#!/bin/bash
# ms1450
# ./passwdCHANGER.sh -p (PASSWORD) usernameA usernameB usernameC ...
#
password="d3f4ult_p4ssw0rd"
while getopts p: flag
do
	case "${flag}" in
		p) password=${OPTARG};;
	esac
done
echo "Changing Passwords..."
echo -e "$password\n$password" | passwd root
i=1;
for user in "$@"
do
	if [[ $i -gt 2 ]]
	then
		echo "Changing $user 's Password";
		echo -e "$password\n$password" | passwd $user
	fi
	i=$((i+1));
done
