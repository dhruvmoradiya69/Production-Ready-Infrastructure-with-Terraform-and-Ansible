#!/bin/bash

# Path to terraform output
TF_OUTPUT=$(terraform -chdir=../terrafrom output -json)

# Extract IPs using jq
DEV_IPS=($(echo "$TF_OUTPUT" | jq -r '.dev_ec2_public_ips.value[]'))
PROD_IPS=($(echo "$TF_OUTPUT" | jq -r '.prod_ec2_public_ips.value[]'))
STAGE_IPS=($(echo "$TF_OUTPUT" | jq -r '.staging_ec2_public_ips.value[]'))

# Function to generate inventory content
generate_inventory() {
    local env_name=$1
    shift
    local ips=("$@")

    local file_path="../ansible/inventories/$env_name"
    {
        echo "[servers]"
        for i in "${!ips[@]}"; do
            echo "server$((i+1)) ansible_host=${ips[$i]}"
        done

        echo ""
        echo "[servers:vars]"
        echo "ansible_user=ubuntu"
        echo "ansible_ssh_private_key_file=/home/dhruv-moradiya/Work/devops_project/Production-Ready-Infrastructure-with-Terraform-and-Ansible/terrafrom/infra-key"
        echo "ansible_python_interpreter=/usr/bin/python3"
    } > "$file_path"

    echo "Updated $file_path"
}

# Update inventories
generate_inventory "dev" "${DEV_IPS[@]}"
generate_inventory "proud" "${PROD_IPS[@]}"
generate_inventory "stage" "${STAGE_IPS[@]}"
