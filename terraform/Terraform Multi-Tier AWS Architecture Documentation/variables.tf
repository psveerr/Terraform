variable "aws_region" {
  type        = string
  default     = "ap-southeast-2"
}

variable "vpc_cidr" {
  type        = string
  default     = "172.31.0.0/16"
}

variable "az_count" {
  type        = number
  default     = 2
}

variable "db_pass" {
  type        = string
  sensitive   = true
}

variable "availability_zones" {
  type        = list(string)
  default     = ["ap-southeast-2a", "ap-southeast-2b"]
}

variable "key_name" {
  type        = string
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  type        = string
}

variable "user_data" {
  type        = string
  default     = ""
}

