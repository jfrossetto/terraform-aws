terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = ">= 3"
  }

  cloud {
    organization = "jfrossetto"
    workspaces {
      name = "terraform-aws"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "ec2" {
  source        = "app.terraform.io/jfrossetto/ec2/aws"
  version       = "1.0.0"
  instance_name = "ec2-teste"
  instance_type = "t3.nano"
}
