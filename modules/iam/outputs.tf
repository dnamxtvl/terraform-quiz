output "ecsTaskExecutionRoleQuiz_arn" {
  value       = aws_iam_role.ecsTaskExecutionRoleQuiz.arn
  description = "ECS Task Execution Role ARN"
}

output "ecsTaskRoleQuiz_arn" {
  value       = aws_iam_role.ecsTaskRoleQuiz.arn
  description = "ECS Task Role ARN"
}

output "lambda_exec_role_arn" {
  value       = aws_iam_role.lambda_exec_role.arn
  description = "Lambda execution role ARN"
}

output "amplify_role_arn" {
  value       = aws_iam_role.amplify_role.arn
  description = "Amplify service role ARN"
}
