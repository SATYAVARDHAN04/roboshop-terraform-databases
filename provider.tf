terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.33.0"
    }
  }

  backend "s3" {
    bucket = "satya2911dev"
    key    = "roboshop-databses"
    region = "us-east-1"
    #dynamodb_table = "satyatable"
    encrypt      = true
    use_lockfile = true # Enables S3 native locking
  }
}

provider "aws" {

}