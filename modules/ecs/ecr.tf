# Elastic Container Registry Definition
resource "aws_ecr_repository" "demo_flask_app" {
  name                 = "demo_flask_app"
  image_tag_mutability = "MUTABLE"
  tags                 = { Name = "${var.name_prefix}-ECR" }

  image_scanning_configuration {
    scan_on_push = var.scan_docker_image_on_push
  }
}

# ECR Lifecycle Policy
resource "aws_ecr_lifecycle_policy" "ecr_lifecycle_policy" {
  for_each = toset([
    aws_ecr_repository.demo_flask_app.name
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
          "countNumber": 2,
          "tagStatus": "any"
        },
        "description": "Expire images older than 2 days",
        "rulePriority": 1
      }
    ]
  }
      EOF
}