# dev-infra
# 2 ec2 instances 1 s3 1 dyanmodb
module "dev-infra" {
    source = "./infra"
    env = "dev"
    instances_count = 2             
    instances_type = "t2.micro"      
    ami_id = "ami-0e35ddab05955cf57"
    volume_size = 10
}

# staging-infra
# 2 ec2 instances 1 s3 1 dyanmodb
module "staging-infra" {
  source = "./infra"
  env = "staging"
  instances_count = 2
  instances_type = "t2.small"
  ami_id = "ami-0e35ddab05955cf57"
  volume_size = 10
}

# prod-infra
# 3 ec2 instances 1 s3 1 dyanmodb
module "prod-infra" {
  source = "./infra"
  env = "prod"
  instances_count = 3
  instances_type = "t2.micro"
  ami_id = "ami-0e35ddab05955cf57"
  volume_size = 10
}

output "dev_ec2_public_ips" {
  value = module.dev-infra.ec2_public_ips
  description = "Public IPs of the EC2 instances in dev environment"
}

output "prod_ec2_public_ips" {
  value = module.prod-infra.ec2_public_ips
  description = "Public IPs of the EC2 instances in dev environment"
}

output "staging_ec2_public_ips" {
  value = module.staging-infra.ec2_public_ips
  description = "Public IPs of the EC2 instances in staging environment"
}
