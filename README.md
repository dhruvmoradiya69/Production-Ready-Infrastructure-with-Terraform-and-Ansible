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
├── ansible
│   ├── inventories
│   │   ├── dev
│   │   ├── proud
│   │   └── stage
│   ├── playbooks
│   │   ├── install_nginx.yml
│   │   └── roles
│   │       └── nginx-role
│   │           ├── defaults
│   │           │   └── main.yml
│   │           ├── files
│   │           │   └── index.html
│   │           ├── handlers
│   │           │   └── main.yml
│   │           ├── meta
│   │           │   └── main.yml
│   │           ├── README.md
│   │           ├── tasks
│   │           │   └── main.yml
│   │           ├── templates
│   │           ├── tests
│   │           │   ├── inventory
│   │           │   └── test.yml
│   │           └── vars
│   │               └── main.yml
│   └── update_invetory.sh
├── backend-terra
│   ├── main.tf
│   └── terrafrom.tf
├── README.md
└── terrafrom
    ├── infra
    │   ├── dyanomdb.tf
    │   ├── ec2.tf
    │   ├── output.tf
    │   ├── s3_bucket.tf
    │   └── variable.tf
    ├── infra-key
    ├── infra-key.pub
    ├── main.tf
    ├── provider.tf
    ├── terraform.tfstate
    ├── terraform.tfstate.backup
    └── terrafrom.tf
```

## Getting Started

### Prerequisites
- Terraform installed
- Ansible installed
- AWS credentials configured

### Terraform Setup

1. Change directory to Terraform:
```bash
cd terraform
```

2. create a ssh key pair:
```bash
# key pair name: infra-key
ssh-keygen -t rsa -b 4096 -C "infra-key"
```

3. Initialize Terraform:
```bash
terraform init
```

4. Review the infrastructure plan:
```bash 
terraform plan
```

5. Apply the infrastructure:
```bash
terraform apply --auto-approve
```

6. Output the public IP addresses of the EC2 instances:
```bash
terraform output
```

7. Destroy the infrastructure when done:
```bash
terraform destroy --auto-approve
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
ansible -i inventories/prod servers -m ping
ansible -i inventories/stage servers -m ping
```

3. Install Ansible roles:
```bash
# Install the nginx role in playbook directory
cd playbooks
ansible-galaxy init nginx-role
```

4. Edit the `nginx-role` tasks to install and configure Nginx:
```bash
# ansible/playbooks/roles/nginx-role/tasks/main.yml
---

- name: Install Nginx
  apt:
    name: nginx
    state: latest
    update_cache: yes

- name: Start & Enable Nginx
  service:
    name: nginx
    state: started
    enabled: yes

- name: Deploy Web Page
  copy:
    src: index.html
    dest: /var/www/html

# make sure to create index.html in the files directory
```

5. Deploy Nginx using the role:
```bash
# Run the playbook for the dev, prod, and stage environments
ansible-playbook -i inventories/dev playbooks/install_nginx.yml
ansible-playbook -i inventories/prod playbooks/install_nginx.yml
ansible-playbook -i inventories/stage playbooks/install_nginx.yml
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
