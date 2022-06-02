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

module "eks" {
  source        = "app.terraform.io/jfrossetto/eks/aws"
  version       = "1.0.1"
  cluster_name  = var.cluster_name
}

module "eks-node-group" {
  source        = "app.terraform.io/jfrossetto/eks-node-group/aws"
  version       = "1.0.1"
  cluster_name  = module.eks.cluster_name
}

