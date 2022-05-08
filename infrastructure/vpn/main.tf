terraform {
  required_version = "~> 1.1.7"

  required_providers {
    aws = {
      version = ">= 4.8.0"
      source  = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket = "terraform-states-flat"
    key    = "states/data-platform/vpn-instance.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      environment = "dev"
      createdVia  = "terraform"
    }
  }
}
