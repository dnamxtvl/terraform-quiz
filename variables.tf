variable "bastion_key_name" {
  description = "SSH key pair name to attach to bastion host (optional). Leave empty to omit."
  type        = string
  default     = ""
}
variable "google_chat_general_webhook" {
  description = "Google Chat webhook URL for general logs"
  type        = string
  sensitive   = true
}

variable "google_chat_error_webhook" {
  description = "Google Chat webhook URL for error logs"
  type        = string
  sensitive   = true
}

variable "db_username" {
  description = "Master username for RDS"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Master password for RDS"
  type        = string
  sensitive   = true
}

variable "baston_ami" {
  description = "AMI ID for the bastion host"
  type        = string
}

variable "domain_name" {
  description = "Domain name for the project"
  type        = string
}

