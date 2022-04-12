variable "username" {
  description = "Root username of the RDS database instance"
  type        = string
  sensitive   = true
}

variable "password" {
  description = "Root password of the RDS database instance"
  type        = string
  sensitive   = true
}

variable "aws_region" {
  description = "AWS region name"
  type        = string
  default     = "us-east-1"
}
