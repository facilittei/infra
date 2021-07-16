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

output "subnet_private_id" {
  description = "The VPC private subnets IDs."
  value       = module.vpc.subnet_private_id
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

output "db_endpoint" {
  description = "The connection endpoint in address:port format."
  value       = module.db.endpoint
}

output "nat_public_dns" {
  description = "The NAT instance public DNS."
  value       = module.ec2.nat_public_dns
}

output "nat_public_ip" {
  description = "The NAT instance IP."
  value       = module.ec2.nat_public_ip
}

output "bastion_public_dns" {
  description = "The bastion instance public DNS."
  value       = module.ec2.bastion_public_dns
}

output "bastion_public_ip" {
  description = "The bastion instance IP."
  value       = module.ec2.bastion_public_ip
}

output "image_nginx_url" {
  description = "Nginx ECR container image registry URL."
  value       = aws_ecr_repository.nginx.repository_url
}

output "image_php_fpm_url" {
  description = "PHP FPM ECR container image registry URL."
  value       = aws_ecr_repository.php-fpm.repository_url
}

output "assets_url" {
  description = "The assets bucket domain name URL."
  value       = aws_s3_bucket.assets.bucket_domain_name
}

output "videos_url" {
  description = "The videos bucket domain name URL."
  value       = aws_s3_bucket.videos.bucket_domain_name
}

output "queue_dlq_url" {
  description = "The URL for the created Amazon SQS queue DLQ."
  value       = aws_sqs_queue.dlq.id
}

output "queue_main_url" {
  description = "The URL for the created Amazon SQS queue."
  value       = aws_sqs_queue.main.id
}

output "cache_nodes" {
  description = "List of node objects including id, address, port and availability_zone."
  value       = aws_elasticache_cluster.main.cache_nodes
}

output "logs_url" {
  description = "The logs bucket domain name URL."
  value       = module.ec2.logs_url
}

output "cdn_domain_name" {
  description = "The domain name corresponding to the distribution."
  value       = module.ec2.cdn_domain_name
}

output "cdn_etag" {
  description = "The current version of the distribution's information."
  value       = module.ec2.cdn_etag
}
