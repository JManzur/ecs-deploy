# ECR Lifecycle Policy
resource "aws_ecr_lifecycle_policy" "advance_demo" {
  for_each = toset([
    aws_ecr_repository.db_connection_test.name
  ])
  repository = each.key

  policy = <<EOF
  {
    "rules": [
      {
        "action": {
          "type": "expire"
        },
        "selection": {
          "countType": "imageCountMoreThan",
          "countNumber": 15,
          "tagStatus": "any"
        },
        "description": "Expire images older than 14 days",
        "rulePriority": 1
      }
    ]
  }
      EOF
}

# Optimal Power Flow ECR Repository:
resource "aws_ecr_repository" "db_connection_test" {
  name                 = "db_connection_test"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = var.scan_docker_image_on_push
  }
}