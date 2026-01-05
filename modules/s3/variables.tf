variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
}

variable "enable_versioning" {
  type        = bool
  default     = true
  description = "Enable S3 versioning"
}

variable "enable_encryption" {
  type        = bool
  default     = true
  description = "Enable server-side encryption"
}

variable "block_public_access" {
  type        = bool
  default     = true
  description = "Block all public access to bucket"
}

variable "enable_logging" {
  type        = bool
  default     = false
  description = "Enable access logging"
}

variable "log_bucket_name" {
  type        = string
  default     = ""
  description = "Bucket for storing access logs"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags for S3 bucket"
}

variable "attach_policy" {
  type        = bool
  default     = false
  description = "Controls if S3 bucket should have bucket policy attached (set to `true` to use value of `policy` as bucket policy)"
}

variable "policy" {
  type        = string
  default     = null
  description = "(Optional) A valid bucket policy JSON document. Optional. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide."
}
