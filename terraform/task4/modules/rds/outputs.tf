output "rds_endpoint" {
  description = "Endpoint of the RDS instance"
  value       = aws_db_instance.this.endpoint
  sensitive   = true
}

output "rds_username" {
  description = "Username for the RDS instance"
  value       = aws_db_instance.this.username
  sensitive   = true
}
