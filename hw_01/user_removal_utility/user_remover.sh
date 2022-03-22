#!/usr/bin/env bash

# Ask the user for the name
echo "Enter account name for removal:"
read varname

# Statement to check whether user actually exists, mitigate root deletion
if [ $varname == "root" ] || [ $varname == "student" ]
then
  echo "ERROR: cannot delete \"$varname\""
elif grep -w  $varname /etc/passwd >> /dev/null
then
  echo "User found"
  now=$(date +"%m_%d_%Y") # Current date will be added to zip name
  zip -r /home/$varname\_${now} /home/$varname
  wait
  mv /home/$varname\_${now}.zip /root/removed_users/
  userdel $varname
  rm -r /home/$varname
  echo "User \"$varname\" has been removed"
else
  echo "User \"$varname\" was not found"
fi

