variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "web_subnets" {
  description = "List of web (public) subnet IDs"
  type        = list(string)
}

variable "app_subnets" {
  description = "List of app (private) subnet IDs"
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

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "user_data" {
  description = "User data script for EC2 instances"
  type        = string
  default     = ""
}

variable "app_port" {
  description = "Port for application traffic"
  type        = number
  default     = 8080
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
