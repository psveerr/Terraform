output "web_sg_id" {
  description = "ID of the Web Security Group"
  value       = aws_security_group.web.id
}

output "app_sg_id" {
  description = "ID of the App Security Group"
  value       = aws_security_group.app.id
}

output "db_sg_id" {
  description = "ID of the DB Security Group"
  value       = aws_security_group.db.id
}
