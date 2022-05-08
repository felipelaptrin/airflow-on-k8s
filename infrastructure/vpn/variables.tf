variable "ec2-ami" {
  description = "ID of the AMI to be used in the EC2 instance that will have the VPN installed."
  type        = string
  default     = "ami-0c4f7023847b90238" # This is a free-tier Ubuntu AMI (20.04 LTS)
}

variable "ec2-instance-type" {
  description = "Instance type of the EC2 that will have the VPN installed."
  type        = string
  default     = "t2.micro" # This is a free-tier instance type (1vCPU / 1Gib Memory)  
}

variable "ec2-key-pair-name" {
  description = "Name of the SSH key-pair to be used to connect into the VPN. This key-pair should be created manually."
  type        = string
}

variable "aws_region" {
  description = "AWS region name"
  type        = string
  default     = "us-east-1"
}
