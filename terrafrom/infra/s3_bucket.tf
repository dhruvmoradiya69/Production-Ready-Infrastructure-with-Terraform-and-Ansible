resource "aws_s3_bucket" "infra_bucket" {
    bucket = "${var.env}-dhruv-test-bucket-t"

    tags = {
      Name = "${var.env}-dhruv-test-bucket-t"
      Environment = var.env
    }
    
}

