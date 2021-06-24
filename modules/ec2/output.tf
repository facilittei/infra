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
