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
