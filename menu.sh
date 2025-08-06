#!/bin/bash

# Source required files
source ~/aws-ec2-shell-script/config.sh
source ~/aws-ec2-shell-script/key-pair.sh
source ~/aws-ec2-shell-script/security-group.sh
source ~/aws-ec2-shell-script/launch-instance.sh

# Function to display menu
show_menu() {
    echo "============================================="
    echo "|           EC2 Management Menu             |"
    echo "============================================="
    echo "| Option |           Action                 |"
    echo "---------------------------------------------"
    echo "|   1    | Create Key Pair                  |"
    echo "|   2    | Create Security Group            |"
    echo "|   3    | Launch EC2 Instance              |"
    echo "|   4    | Exit                             |"
    echo "============================================="
}

while true; do
    show_menu
    read -p "Enter your choice from menu [1-4]: " choice

    case $choice in
        1)
            echo ">> Creating key-pair..."
            create_key
            ;;
        2)
            echo ">> Creating security group..."
            create_group
            ;;
        3)
            echo ">> Launching EC2 instance(s)..."
            launch_instance
            ;;
        4)
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter a number between 1 and 4."
            ;;
    esac

    echo ""
    read -p "Press enter to continue..."
done