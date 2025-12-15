output "repository_nginx_url" {
  value = module.ecr_nginx.repository_url
}

output "repository_php_fpm_url" {
  value = module.ecr_php_fpm.repository_url
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
