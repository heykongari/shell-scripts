#!/bin/bash

# Function to create a new key-pair.
create_key() {

    # create a directory to save .pem file. Ignores if already exists.
    mkdir -p ~/.aws/

    read -p "Enter a name for new key-pair (e.g. aws-key): " name

    while true; do

        if [[ -n $name ]]; then

            # commad to create a new key-pair.
            aws ec2 create-key-pair \
            --key-name "$name" \
            --query "KeyMaterial" \
            --output text > ~/.aws/$name.pem

            # change permissions to read-only. 
            chmod 400 ~/.aws/$name.pem

            echo "Key-pair created successfully and saved to ~/.aws/$name.pem"

            break

        else
            echo "Name cannot be empty. Please enter a valid name."
        fi

    done
}