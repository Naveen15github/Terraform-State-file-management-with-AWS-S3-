terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "naveen-s3-terraform-state"
    key    = "dev/terraform.tfstate"
    region = "ap-south-1"
    encrypt = true
    # If you need other backend options (profile, role_arn, kms_key_id) add them here.
  }
}

provider "aws" {
  region = "ap-south-1"
  # optional: profile = "myprofile"
}

resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "aws_s3_bucket" "test_backend" {
  bucket = "test-remote-backend-${random_string.bucket_suffix.result}"

  tags = {
    Name        = "Test Backend Bucket"
    Environment = "dev"
  }
}
