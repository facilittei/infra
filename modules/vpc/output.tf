output "vpc_id" {
  value = aws_vpc.main.id
}

output "igw_id" {
  value = aws_internet_gateway.main.id
}

output "subnet_public_id" {
  value = aws_subnet.public.*.id
}
