terraform {
  required_version = ">=1.8.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    region = "us-east-1"
    bucket = "<your-bucket-terraform-backend>"
    key    = "terraform.tfstate"
  }
}
