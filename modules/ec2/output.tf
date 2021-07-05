output "sg_lb" {
  value = aws_security_group.lb.id
}

output "sg_api" {
  value = aws_security_group.api.id
}

output "lb_id" {
  value = aws_lb.main.id
}

output "lb_dns_name" {
  value = aws_lb.main.dns_name
}

output "instances_public_ip_0" {
  value = aws_instance.api.0.public_ip
}

output "instances_public_ip_1" {
  value = aws_instance.api.1.public_ip
}

output "instances_public_dns_0" {
  value = aws_instance.api.0.public_dns
}

output "instances_public_dns_1" {
  value = aws_instance.api.1.public_dns
}

output "nat_public_dns" {
  value = aws_instance.nat.public_dns
}

output "nat_public_ip" {
  value = aws_instance.nat.public_ip
}

output "bastion_public_dns" {
  value = aws_instance.bastion.public_dns
}

output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "logs_url" {
  value = aws_s3_bucket.logs.bucket_domain_name
}

output "cdn_domain_name" {
  value = aws_cloudfront_distribution.main.domain_name
}

output "cdn_etag" {
  value = aws_cloudfront_distribution.main.etag
}
