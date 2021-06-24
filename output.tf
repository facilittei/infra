output "vpc_id" {
  description = "The VPC ID provisioned."
  value       = module.vpc.vpc_id
}

output "igw_id" {
  description = "The Internet Gateway ID provisioned."
  value       = module.vpc.igw_id
}

output "subnet_public_id" {
  description = "The VPC public subnets IDs."
  value       = module.vpc.subnet_public_id
}

output "sg_lb" {
  description = "The security group for the load balancer."
  value       = module.ec2.sg_lb
}

output "sg_api" {
  description = "The security group for the API."
  value       = module.ec2.sg_api
}

output "lb_id" {
  description = "The ID of the load balancer."
  value       = module.ec2.lb_id
}

output "lb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = module.ec2.lb_dns_name
}

output "instances_public_ip_0" {
  description = "The instances IP 0."
  value       = module.ec2.instances_public_ip_0
}

output "instances_public_ip_1" {
  description = "The instances IP 1."
  value       = module.ec2.instances_public_ip_1
}

output "instances_public_dns_0" {
  description = "The instances DNS 0."
  value       = module.ec2.instances_public_dns_0
}

output "instances_public_dns_1" {
  description = "The instances DNS 1."
  value       = module.ec2.instances_public_dns_1
}
