#!/bin/bash

# Function to create a new key-pair.
create_key() {

    # create a directory to save .pem file. Ignores, if the folder/directory already exists.
    mkdir -p ~/.aws/

    read -p "Enter a name for new key-pair (e.g. aws-key): " name

    while true; do

        if [[ -n "$name" ]]; then

            aws ec2 create-key-pair \
            --key-name "$name" \
            --query "KeyMaterial" \
            --output text > ~/.aws/"$name".pem

            # change permissions to read-only. 
            chmod 400 ~/.aws/"$name".pem

            echo "Key-pair created successfully and saved to ~/.aws/"$name".pem"
            echo ""
            echo "*Update config.sh before running an EC2 instance.*"

            break

        else
            echo "Name cannot be empty. Please enter a valid name."
        fi

    done
}