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

module "vpc" {
  source          = "app.terraform.io/jfrossetto/vpc/aws"
  version         = "1.0.1"    
  vpc_cidr        = var.vpc_cidr
  count_nat       = var.count_nat
  private_subnets = module.vpc.private_subnets
  public_subnets  = module.vpc.public_subnets
  nat_ips         = module.vpc.nat_ips
  nat_gateway     = module.vpc.nat_gateway
}

module "ec2" {
  source        = "app.terraform.io/jfrossetto/ec2/aws"
  version       = "1.1.3"
  instance_name = "ec2-teste"
  instance_type = "t3.nano"
  security_rds = aws_security_group.allow_rds.id
  private_subnets = module.vpc.private_subnets
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

data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["default"]
  }  
}


