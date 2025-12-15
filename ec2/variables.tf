variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "security_group_baston_name" {
  description = "Security group name for baston host"
  type        = string
}

variable "vpc" {
  description = "VPC object (module.vpc)"
  type        = any
}

variable "key_name" {
  description = "Optional SSH key pair name for the bastion host"
  type        = string
  default     = ""
}