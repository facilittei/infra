variable "environment" {
  type        = string
  description = "The environment provisioned."
}

variable "product" {
  description = "The product to be provisioned."
  default     = "facilittei"
}

variable "region" {
  description = "The instance region to be provisioned."
  default     = "us-east-1"
}

variable "cidr" {
  description = "The IPv4 CIDR block of the VPC."
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "The list of availability zones to be provisioned."
  default     = ["us-east-1a", "us-east-1b"]
}

variable "subnets_public" {
  description = "The VPC public subnets."
  default     = ["10.0.32.0/20", "10.0.48.0/20"]
}

variable "instance_type" {
  description = "The Amazon Machine Image instance type."
  default     = "t2.micro"
}

variable "public_key" {
  type        = string
  description = "The EC2 instance public key."
  sensitive   = true
}

variable "certificate_domain_api" {
  type        = string
  description = "The domain of the certificate of the API."
}
