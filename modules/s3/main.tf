module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 5.9"
  region  = "ap-southeast-1"

  bucket = var.bucket_name

  # Versioning
  versioning = {
    enabled = var.enable_versioning
  }

  # Allow deletion of non-empty bucket
  force_destroy = true

  # Server-side encryption
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  # Block public access
  block_public_acls       = var.block_public_access
  block_public_policy     = var.block_public_access
  ignore_public_acls      = var.block_public_access
  restrict_public_buckets = var.block_public_access

  # Object ownership - BucketOwnerEnforced (ACLs disabled, recommended for new buckets)
  control_object_ownership = true
  object_ownership         = "BucketOwnerEnforced"

  # Bucket policy - deny unencrypted uploads and non-HTTPS
  attach_deny_unencrypted_object_uploads = false
  attach_deny_insecure_transport_policy  = false

  # Logging
  logging = var.enable_logging && var.log_bucket_name != "" ? {
    target_bucket = var.log_bucket_name
    target_prefix = "${var.bucket_name}/"
  } : {}

  attach_policy = var.attach_policy
  policy        = var.policy

  tags = var.tags
}
