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
