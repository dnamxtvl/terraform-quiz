output "ecs_cluster_id" {
  value       = aws_ecs_cluster.ecs_cluster.id
  description = "ECS cluster ID"
}

output "ecs_service_name" {
  value       = aws_ecs_service.ecs_service.name
  description = "ECS service name"
}
