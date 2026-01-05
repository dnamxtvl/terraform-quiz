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

# IAM Role for Amplify
resource "aws_iam_role" "amplify_role" {
  name = "amplify-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "amplify.amazonaws.com"
        }
      }
    ]
  })
}

# Full access to CodeCommit
resource "aws_iam_role_policy" "amplify_codecommit_policy" {
  name = "amplify-codecommit-full-access"
  role = aws_iam_role.amplify_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "codecommit:GitPush",
          "codecommit:GitPull",
          "codecommit:GetBranch",
          "codecommit:GetCommit",
          "codecommit:GetRepository",
          "codecommit:ListBranches",
          "codecommit:ListRepositories",
          "codecommit:CreateCommit",
          "codecommit:GetBlob",
          "codecommit:GetTree",
          "codecommit:PutFile",
          "codecommit:GetFile",
          "codecommit:GetDifferences",
          "codecommit:GetMergeCommit",
          "codecommit:GetMergeConflicts",
          "codecommit:GetMergeOptions",
          "codecommit:GetPullRequest",
          "codecommit:ListPullRequests",
          "codecommit:PostCommentForPullRequest",
          "codecommit:PostCommentReply",
          "codecommit:UpdatePullRequestDescription",
          "codecommit:UpdatePullRequestStatus",
          "codecommit:UpdatePullRequestTitle",
          "codecommit:DescribePullRequestEvents",
          "codecommit:GetCommentsForPullRequest",
          "codecommit:GetCommentsForComparedCommit",
          "codecommit:GetCommitHistory",
          "codecommit:GetCommitsFromMergeBase",
          "codecommit:GetReferences",
          "codecommit:ListCommitsInMergeCommit",
          "codecommit:ListTagsForResource",
          "codecommit:MergePullRequestByFastForward",
          "codecommit:MergePullRequestBySquash",
          "codecommit:MergePullRequestByThreeWay",
          "codecommit:PostCommentForComparedCommit",
          "codecommit:PutFile",
          "codecommit:TestRepositoryTriggers",
          "codecommit:UpdateDefaultBranch",
          "codecommit:UpdateRepositoryDescription",
          "codecommit:UpdateRepositoryName"
        ]
        Resource = "*"
      }
    ]
  })
}

# CloudWatch Logs permissions
resource "aws_iam_role_policy" "amplify_cloudwatch_policy" {
  name = "amplify-cloudwatch-logs"
  role = aws_iam_role.amplify_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ]
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}