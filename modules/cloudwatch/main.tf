data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

# Create log group for ECS containers
# This must exist before subscription filter can be created
resource "aws_cloudwatch_log_group" "ecs" {
  name              = var.log_group_name
  retention_in_days = 14
}

resource "aws_lambda_permission" "allow_cw_logs" {
  statement_id  = "AllowCWLogsInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_arn
  principal     = "logs.${data.aws_region.current.id}.amazonaws.com"
  source_arn    = "arn:aws:logs:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:log-group:${var.log_group_name}:*"
}

resource "aws_cloudwatch_log_subscription_filter" "ecs_to_lambda" {
  name            = "quiz-ecs-to-lambda"
  log_group_name  = aws_cloudwatch_log_group.ecs.name
  filter_pattern  = var.filter_pattern
  destination_arn = var.lambda_arn

  depends_on = [
    aws_lambda_permission.allow_cw_logs,
    aws_cloudwatch_log_group.ecs
  ]
}