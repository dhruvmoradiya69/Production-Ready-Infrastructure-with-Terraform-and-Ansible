resource "aws_dynamodb_table" "infra_db" {
  
  name = "${var.env}-dhruv-test-table"
  
  billing_mode = "PAY_PER_REQUEST"
  
  hash_key = "userID"
  
  attribute {
    name = "userID"
    type = "S"
  }

  tags = {
    Name = "${var.env}-dhruv-test-table"
    Environment = var.env
  }

}
