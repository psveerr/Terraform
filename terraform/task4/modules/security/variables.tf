variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "app_port" {
  description = "Port for application traffic"
  type        = number
  default     = 8080
}

variable "db_port" {
  description = "Port for database traffic"
  type        = number
  default     = 5432
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
