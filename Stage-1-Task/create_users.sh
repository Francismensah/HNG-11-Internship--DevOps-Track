#!/bin/bash

# Check if the user has provided a file name
if [ $# -eq 0 ]; then
    echo "Usage: $0 user_list.txt"
    exit 1
fi

users_file=$1

# Ensure the users file exists
if [ ! -f $users_file ]; then
    echo "File $users_file does not exist."
    exit 1
fi

# Log and password file paths
log_file="/var/log/user_management.log"
password_file="/var/secure/user_passwords.txt"

# Ensure /var/secure directory exists
mkdir -p /var/secure
chmod 700 /var/secure

# Ensure the log file exists
touch $log_file

# Start logging
echo "User creation process started at $(date)" >> $log_file

# Process each line of the users file
while IFS=';' read -r username groups; do
    # Remove whitespace
    username=$(echo $username | xargs)
    groups=$(echo $groups | xargs)

    # Check if user already exists
    if id "$username" &>/dev/null; then
        echo "User $username already exists. Skipping..." >> $log_file
        continue
    fi

    # Create user and user's primary group
    useradd -m -s /bin/bash "$username"
    echo "Created user $username" >> $log_file

    # Create and assign secondary groups
    IFS=',' read -ra group_list <<< "$groups"
    for group in "${group_list[@]}"; do
        group=$(echo $group | xargs)
        if ! getent group "$group" &>/dev/null; then
            groupadd "$group"
            echo "Created group $group" >> $log_file
        fi
        usermod -aG "$group" "$username"
        echo "Added user $username to group $group" >> $log_file
    done

    # Generate a random password
    password=$(openssl rand -base64 12)
    echo "$username:$password" | chpasswd
    echo "$username,$password" >> $password_file

    # Set permissions for user's home directory
    chmod 700 /home/$username
    chown $username:$username /home/$username
    echo "Set permissions for /home/$username" >> $log_file

done < "$users_file"

# Secure the password file
chmod 600 $password_file
chown root:root $password_file

echo "User creation process completed at $(date)" >> $log_file
