variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "web_sg" {
  description = "ID of the web security group"
  type        = string
}

variable "app_sg" {
  description = "ID of the app security group"
  type        = string
}

variable "web_target_arn" {
  description = "ARN of the web target group"
  type        = string
}

variable "app_target_arn" {
  description = "ARN of the app target group"
  type        = string
}

variable "app_port" {
  description = "Port for application traffic"
  type        = number
  default     = 8080
}

variable "enable_https" {
  description = "Enable HTTPS listeners"
  type        = bool
  default     = false
}

variable "certificate_arn" {
  description = "ARN of the ACM certificate for HTTPS"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
