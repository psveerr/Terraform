output "web_alb_dns_name" {
  description = "DNS name of the public ALB"
  value       = aws_lb.web.dns_name
}

output "app_alb_dns_name" {
  description = "DNS name of the private ALB"
  value       = aws_lb.app.dns_name
}

output "web_alb_arn" {
  description = "ARN of the public ALB"
  value       = aws_lb.web.arn
}

output "app_alb_arn" {
  description = "ARN of the private ALB"
  value       = aws_lb.app.arn
}
