terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "facilittei-terraform-state"
    key    = "facilittei.terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source         = "./modules/vpc"
  environment    = var.environment
  product        = var.product
  region         = var.region
  cidr           = var.cidr
  azs            = var.azs
  subnets_public = var.subnets_public
}

module "ec2" {
  source        = "./modules/ec2"
  environment   = var.environment
  product       = var.product
  azs           = var.azs
  instance_type = var.instance_type
}
