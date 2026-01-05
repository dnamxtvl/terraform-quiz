variable "lambda_role_arn" {
  description = "IAM role ARN for the log forwarding Lambda"
  type        = string
}

variable "google_chat_general_webhook" {
  description = "Google Chat webhook for general logs"
  type        = string
  sensitive   = true
}

variable "google_chat_error_webhook" {
  description = "Google Chat webhook for error logs"
  type        = string
  sensitive   = true
}

