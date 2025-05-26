output "web_target_group_arn" {
  description = "ARN of the web target group"
  value       = aws_lb_target_group.web.arn
}

output "app_target_group_arn" {
  description = "ARN of the app target group"
  value       = aws_lb_target_group.app.arn
}
