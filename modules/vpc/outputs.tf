output "vpc_id" {
  description = "value of the VPC ID"
  value       = aws_vpc.main.id
}

output "private_subnets" {
  description = "value of the private subnet ID"
  value       = [aws_subnet.private_zone1.id]
}
