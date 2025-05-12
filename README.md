# Production Ready Infrastructure with Terraform and Ansible

This project demonstrates setting up production-ready infrastructure on AWS using Terraform for infrastructure provisioning and Ansible for configuration management.

## Infrastructure Overview

The infrastructure is provisioned across three environments:

### Development Environment
- 2 EC2 instances (t2.micro)
- 1 DynamoDB table  
- 1 S3 bucket
- Security group with SSH, HTTP and HTTPS access

### Staging Environment
- 2 EC2 instances (t2.small)  
- 1 DynamoDB table
- 1 S3 bucket
- Security group with SSH, HTTP and HTTPS access

### Production Environment  
- 3 EC2 instances (t2.micro)
- 1 DynamoDB table
- 1 S3 bucket
- Security group with SSH, HTTP and HTTPS access

## Project Structure

```
.
├── ansible/
│   ├── inventories/         # Environment-specific inventories
│   │   ├── dev
│   │   ├── prod  
│   │   └── stage
│   ├── playbooks/          # Ansible playbooks
│   │   ├── install_nginx.yml
│   │   └── roles/
│   │       └── nginx-role/
│   └── update_inventory.sh  # Script to update inventories
└── terraform/
    ├── infra/              # Terraform modules
    │   ├── dynamodb.tf
    │   ├── ec2.tf
    │   ├── output.tf
    │   ├── s3_bucket.tf
    │   └── variable.tf
    ├── main.tf             # Main Terraform configuration
    └── provider.tf         # AWS provider configuration
```

## Getting Started

### Prerequisites
- Terraform installed
- Ansible installed
- AWS credentials configured

### Terraform Setup

1. Initialize Terraform:
```bash
cd terraform
terraform init
```

2. Review the infrastructure plan:
```bash 
terraform plan
```

3. Apply the infrastructure:
```bash
terraform apply
```

### Ansible Setup

1. Update inventory files:
```bash
cd ansible
./update_inventory.sh
```

2. Test connectivity:
```bash
#ping all servers dev prod stage
ansible -i inventories/dev servers -m ping
```

3. Install Ansible roles:
```bash
# Install the nginx role
ansible-galaxy init nginx-role
```

4. Deploy Nginx using the role:
```bash
# Run the playbook for the dev, prod, and stage environments
ansible-playbook -i inventories/dev playbooks/install_nginx.yml
```

## Infrastructure Details

- Each environment uses a dedicated module from `terraform/infra/`
- Security groups allow inbound traffic on ports 22 (SSH), 80 (HTTP), and 443 (HTTPS)
- EC2 instances use the specified instance types per environment
- DynamoDB tables use on-demand capacity mode
- S3 buckets are created with environment-specific names

## Configuration Management

- Ansible uses environment-specific inventory files
- The nginx-role handles Nginx installation and configuration
- SSH key authentication is used for connecting to instances
- Python 3 is used as the interpreter on target hosts
