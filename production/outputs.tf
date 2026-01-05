// Outputs to export from VPC module
output "vpc" {
  value = module.vpc
}

output "nat_gateway_public_ip" {
  value       = module.vpc.nat_gateway_public_ip
  description = "Public IP của NAT Gateway cho partner whitelist"
}

output "private_subnets_ecs" {
  value = module.vpc.private_subnets_ecs
}

output "private_subnets_rds" {
  value = module.vpc.private_subnets_rds
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "sg" {
  value = module.sg.sg_system
}

output "rds_subnet_group_name" {
  value = module.vpc.rds_subnet_group_name
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "ecr_repository_nginx_url" {
  value       = module.ecr.repository_nginx_url
  description = "ECR repository URL for nginx image"
}

output "ecr_repository_php_fpm_url" {
  value       = module.ecr.repository_php_fpm_url
  description = "ECR repository URL for php-fpm image"
}

output "aws_account_id" {
  value       = module.ecr.account_id
  description = "AWS account ID"
}

output "elasticache_endpoint" {
  value       = module.elasticache.elasticache_endpoint
  description = "ElastiCache Redis endpoint"
}

output "elasticache_port" {
  value       = module.elasticache.elasticache_port
  description = "ElastiCache Redis port"
}

output "s3_bucket_id" {
  value       = module.s3.bucket_id
  description = "S3 bucket name"
}

output "s3_bucket_arn" {
  value       = module.s3.bucket_arn
  description = "S3 bucket ARN"
}

output "s3_bucket_domain_name" {
  value       = module.s3.bucket_domain_name
  description = "S3 bucket domain name"
}