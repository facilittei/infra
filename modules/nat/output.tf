output "public_dns" {
  value = aws_instance.nat.public_dns
}

output "public_ip" {
  value = aws_instance.nat.public_ip
}
