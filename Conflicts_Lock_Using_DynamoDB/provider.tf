terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-s3-practise"
    key            = "terraformSingleInstance.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "dynamodb-state-locking"
  }
}

# Configure the AWS Providers
provider "aws" {
  region = "ap-south-1"
}