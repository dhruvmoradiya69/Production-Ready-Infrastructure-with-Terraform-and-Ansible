terraform {
   required_providers {
     aws = {
       source = "hashicorp/aws"
      version = "6.0.0-beta2"
     }
   }

  backend "s3" {
    bucket         = "ica-terraform-backend"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "ica-terraform-lock-table"
  }
}

