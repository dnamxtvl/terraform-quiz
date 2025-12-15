resource "aws_iam_role" "ecsTaskExecutionRoleQuiz" {
  name               = "quiz-app-ecsTaskExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.ecsTaskExecutionRoleQuiz.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "ecsTaskRoleQuiz" {
  name               = "ecsTaskRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ecsTaskRole_rds_policy" {
  role       = aws_iam_role.ecsTaskRoleQuiz.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

resource "aws_iam_role_policy_attachment" "ecsTaskRole_elasticache_policy" {
  role       = aws_iam_role.ecsTaskRoleQuiz.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonElastiCacheFullAccess"
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}