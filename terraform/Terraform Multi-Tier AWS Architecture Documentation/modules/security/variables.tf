variable "vpc_id" {
  type        = string
}

variable "app_port" {
  type        = number
  default     = 8080
}

variable "db_port" {
  type        = number
  default     = 5432
}

variable "tags" {
  type        = map(string)
  default     = {}
}
