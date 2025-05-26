output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of private (app) subnet IDs"
  value       = module.vpc.private_subnets
}

output "db_subnets" {
  description = "List of private (db) subnet IDs"
  value       = module.vpc.db_subnets
}

output "web_alb_dns_name" {
  description = "DNS name of the public ALB"
  value       = module.alb.web_alb_dns_name
}

output "app_alb_dns_name" {
  description = "DNS name of the private ALB"
  value       = module.alb.app_alb_dns_name
}

output "rds_endpoint" {
  description = "Endpoint of the RDS instance"
  value       = module.rds.rds_endpoint
  sensitive   = true
}
