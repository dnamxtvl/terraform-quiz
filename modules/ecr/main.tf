# Data sources
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# ECR repositories using terraform-aws-modules
module "ecr_nginx" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "~> 2.0"

  repository_name = "quiz-nginx"

  repository_image_tag_mutability = "MUTABLE"

  repository_image_scan_on_push = true

  repository_force_delete = true

  # Lifecycle policy - expire images older than 30 days
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire images older than 30 days"
        selection = {
          tagStatus   = "any"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = 30
        }
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = {
    Name = "quiz-nginx"
  }
}

module "ecr_php_fpm" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "~> 2.0"

  repository_name = "quiz-php-fpm"

  repository_image_tag_mutability = "MUTABLE"

  repository_image_scan_on_push = true

  repository_force_delete = true

  # Lifecycle policy - expire images older than 30 days
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire images older than 30 days"
        selection = {
          tagStatus   = "any"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = 30
        }
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = {
    Name = "quiz-php-fpm"
  }
}
