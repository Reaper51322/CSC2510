#!/bin/bash

# Check if the correct number of arguments was received
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <file_with_usernames> <username>"
    exit 1
fi

file_with_usernames=$1
username=$2

# Check if the file exists and is a regular file
if [ ! -f "$file_with_usernames" ]; then
    echo "Error: File $file_with_usernames does not exist or is not a regular file."
    exit 1
fi

# Check if the username exists in the file
line_number=$(grep -n -x "$username" "$file_with_usernames" | cut -d ':' -f 1)

if [ -n "$line_number" ]; then
    echo "Username $username exists in $file_with_usernames at line $line_number."
else
    while true; do
        read -p "Username $username does not exist in $file_with_usernames. Would you like to add it? (Y/N): " response
        case $response in
            [Yy]*)
                while true; do
                    read -p "Do you want $file_with_usernames to be alphabetized after adding the new name? (Y/N): " alphabetize_response
                    case $alphabetize_response in
                        [Yy]*)
                            echo "$username" >> "$file_with_usernames"
                            sort -o "$file_with_usernames" "$file_with_usernames"
                            echo "$username added and $file_with_usernames alphabetized."
                            exit 0
                            ;;
                        [Nn]*)
                            echo "$username" >> "$file_with_usernames"
                            echo "$username added."
                            exit 0
                            ;;
                        *)
                            echo "Invalid response. Please enter Y or N."
                            ;;
                    esac
                done
                ;;
            [Nn]*)
                echo "User chose not to add $username. Exiting."
                exit 0
                ;;
            *)
                echo "Invalid response. Please enter Y or N."
                ;;
        esac
    done
fi
