output "ec2_public_ips" {
  value = aws_instance.new_instance[*].public_ip
  description = "Public IPs of the EC2 instances"
}

output "ec2_private_ips" {
  value = aws_instance.new_instance[*].private_ip
  description = "Private IPs of the EC2 instances"
}

