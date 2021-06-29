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
  source          = "./modules/vpc"
  environment     = var.environment
  product         = var.product
  region          = var.region
  cidr            = var.cidr
  azs             = var.azs
  subnets_public  = var.subnets_public
  subnets_private = var.subnets_private
}

module "ec2" {
  source                 = "./modules/ec2"
  environment            = var.environment
  product                = var.product
  azs                    = var.azs
  instance_type          = var.instance_type
  public_key             = var.public_key
  certificate_domain_api = var.certificate_domain_api
}

module "db" {
  source           = "./modules/db"
  environment      = var.environment
  product          = var.product
  db_username      = var.db_username
  db_password      = var.db_password
  db_name          = var.db_name
  db_instance_type = var.db_instance_type
}
