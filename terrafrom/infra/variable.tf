variable "env" {
  description = "The environment to deploy"
  type        = string
}

variable "instances_type" {
  description = "type of instances to deploy"
  type        = string
}

variable "instances_count" {
  description = "number of instances to deploy"
  type        = number
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instances"
  type        = string
}

variable "volume_size" {
  description = "The size root ebs of the EC2 instances"
  type        = number
}

