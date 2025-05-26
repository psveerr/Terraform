variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private (app) subnet IDs"
  type        = list(string)
}

variable "db_subnets" {
  description = "List of private (db) subnet IDs"
  type        = list(string)
}

variable "az_count" {
  description = "Number of availability zones"
  type        = number
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
