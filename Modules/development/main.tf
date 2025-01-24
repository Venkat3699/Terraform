terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "terraform-s3-bucket-1234"
    key    = "dev-backup.tfstate"
    region = "us-east-1"
  }
}

# Configure the AWS Providers
provider "aws" {
  region = var.region
}