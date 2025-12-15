output "rds_instance_id" {
  value       = aws_db_instance.database.id
  description = "RDS instance ID"
}

output "rds_endpoint" {
  value       = aws_db_instance.database.endpoint
  description = "RDS instance endpoint (address:port)"
}

output "rds_address" {
  value       = aws_db_instance.database.address
  description = "RDS instance address"
}

output "rds_port" {
  value       = aws_db_instance.database.port
  description = "RDS instance port"
}
