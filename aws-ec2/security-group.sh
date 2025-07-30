#!/bin/bash

# Function to create a new security group with ssh ingress
create_group() {

    read -p "Enter a name for new security group (e.g. devops-sg): " group_name
    read -p "Enter a short description: " group_desc

    while true; do

        if [[ -n "$name" && -n "$group_desc" ]]; then

            GROUP_ID=$(aws ec2 create-security-group \
            --group-name "$group_name" \
            --description "$group_desc" \
            --query "GroupId" \
            --output text)

            # allow SSH connection from any IP
            aws ec2 authorize-security-group-ingress \
            --group-id "$GROUP_ID" \
            --protocol tcp \
            --port 22 \
            --cidr 0.0.0.0/0 > /dev/null 2>&1

            echo "Security group created successfully."
            echo "Security Group (ID): $group_name ($GROUP_ID)"
            echo ""
            echo "*Update config.sh before running an EC2 instance.*"

            break

        else
            echo "Invalid Input. Name and Description cannot be empty."
        fi

    done
}