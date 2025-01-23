resource "aws_dynamodb_table" "state_locking" {
  name     = "dynamodb-state-locking"
  hash_key = "LOCKID"
  attribute {
    name = "LOCKID"
    type = "S"
  }
  billing_mode = "PAY_PER_REQUEST"
}