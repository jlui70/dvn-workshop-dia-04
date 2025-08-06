variable "tags" {
  type = map(string)
  default = {
    Project     = "terraform-devops-project"
    Environment = "production"
  }
}

variable "auth" {
  type = object({
    assume_role_arn = string
    region          = string
  })

  default = {
    assume_role_arn = "arn:aws:iam::794038226274:role/workshop-role"
    region          = "us-east-1"
  }
}

variable "remote_backend" {
  type = object({
    s3_bucket                   = string
    dynamodb_table_name         = string
    dynamodb_table_billing_mode = string
    dynamodb_table_hash_key     = string
  })

  default = {
    s3_bucket                   = "devopsproject-s3-remote-backend-bucket"
    dynamodb_table_name         = "devopsproject-s3-state-locking-table"
    dynamodb_table_billing_mode = "PAY_PER_REQUEST"
    dynamodb_table_hash_key     = "LockID"
  }
}
