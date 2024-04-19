# store the terraform state file in s3
terraform {
  backend "s3" {
    bucket         = "ilovess3"
    key            = "itzchioma/terraform/remote/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "dynamodb-state-locking"
  }
}