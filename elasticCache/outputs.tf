output "elasticache_endpoint" {
  value = aws_elasticache_replication_group.redis.primary_endpoint_address
}

output "elasticache_port" {
  value = aws_elasticache_replication_group.redis.port
}

output "redis_auth_token" {
  value       = random_password.redis_auth_token.result
  sensitive   = true
  description = "Redis authentication token for TLS connection"
}