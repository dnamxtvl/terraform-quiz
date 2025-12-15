output "alb_dns_name" {
  value       = aws_lb.application_load_balancer.dns_name
  description = "DNS name of the load balancer"
}

output "alb_arn" {
  value       = aws_lb.application_load_balancer.arn
  description = "ARN of the load balancer"
}

output "target_group_arn" {
  value       = aws_lb_target_group.target_group.arn
  description = "ARN of the target group"
}

output "listener_arn" {
  value       = aws_lb_listener.listener.arn
  description = "ARN of the listener"
}
