resource "aws_s3_bucket" "backend_bucket" {
    bucket = "ica-terraform-backend"
    force_destroy = true

    tags = {
      Name = "ica-terraform-backend-td"
    } 
}

resource "aws_dynamodb_table" "backend_lock_table" {
    name         = "ica-terraform-lock-table"
    billing_mode = "PAY_PER_REQUEST"
    hash_key     = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }

    tags = {
        Name = "ica-terraform-lock-table"
    }
}
