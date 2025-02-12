terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.84.0"
    }
  }

  backend "s3" {
    bucket = "sri.tf" #bucket only for one project s3 bucket
    key    = " project"
    region = "us-east-1"
    dynamodb_table = "sri-state-locking"   #only for onr table 
  }
}
provider "aws" {
  # Configuration options
}