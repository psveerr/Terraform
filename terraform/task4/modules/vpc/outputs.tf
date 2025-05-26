output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.this.id
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "private_subnets" {
  description = "List of private (app) subnet IDs"
  value       = aws_subnet.private_app[*].id
}

output "db_subnets" {
  description = "List of private (db) subnet IDs"
  value       = aws_subnet.private_db[*].id
}
