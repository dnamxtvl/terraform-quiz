variable "lambda_arn" {
  description = "Destination Lambda ARN for the subscription filter"
  type        = string
}

variable "log_group_name" {
  description = "CloudWatch log group name to subscribe"
  type        = string
}

variable "filter_pattern" {
  description = "Optional filter pattern for subscription"
  type        = string
  default     = ""
}

