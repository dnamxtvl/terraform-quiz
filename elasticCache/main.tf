resource "random_password" "redis_auth_token" {
  length  = 32
  special = true
}

resource "aws_elasticache_replication_group" "redis" {
  replication_group_id = "quiz-redis"
  description          = "Redis cluster for Quiz app"

  node_type      = "cache.t3.micro"
  engine         = "redis"
  engine_version = "7.0"

  num_cache_clusters = 1

  port                 = 6379
  parameter_group_name = "default.redis7"

  subnet_group_name  = var.elasticache_subnet_group_name
  security_group_ids = [var.sg.elasticache]

  # Enable ACL + encryption
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true

  automatic_failover_enabled = false
}

