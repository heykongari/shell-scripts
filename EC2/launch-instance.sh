#!/bin/bash

# Function to launch an EC2 instance.
launch_instance() {

    if [[ -n "$KEY_NAME" && -n "$SG_ID" ]]; then

        echo "Launching "$INSTANCE_COUNT" instance(s) with key-pair: "$KEY_NAME" & Security group ID: "$SG_ID"."
        
        INSTANCE_ID=$(aws ec2 run-instances \
        --image-id "$AMI_ID" \
        --instance-type "$INSTANCE_TYPE" \
        --count "$INSTANCE_COUNT" \
        --key-name "$KEY_NAME" \
        --security-group-ids "$SG_ID" \
        --region "$REGION" \
        --query "Instances[*].InstanceId" \
        --output text)

    else
        echo "Key-pair and Security Group ID cannot be empty. Check if all the variables are declared in config.sh file."
    fi

    if [[ $? -eq 0 && -n "$INSTANCE_ID" ]]; then

        echo "Launched $INSTANCE_COUNT instance(s) successfully."
        echo "Loading instance(s) info..."

        # display details in a tabbular format.
        aws ec2 describe-instances \
        --query "Reservations[*].Instances[*].[ImageId,InstanceId,PublicIpAddress]" \
        --output table

    else
        echo "Failed to launch instance(s)."
        return 1
    fi

}