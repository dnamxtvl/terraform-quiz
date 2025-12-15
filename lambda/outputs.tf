output "lambda_arn" {
  description = "ARN of the log forwarding Lambda"
  value       = aws_lambda_function.log_channel.arn
}

