### IMPORTANT: Run this module after the VPC deployment by using: "terraform apply -target=aws_ecr_repository.demo-repo" ###

# Elastic Container Registry Definition
resource "aws_ecr_repository" "demo-repo" {
  name                 = "demo-repository"
  image_tag_mutability = "MUTABLE"
  tags                 = merge(var.demo_tags, { Name = "${var.tag_project}-repo" }, )

  image_scanning_configuration {
    scan_on_push = false
  }
}

# ECR Lifecycle Policy
resource "aws_ecr_lifecycle_policy" "demo-repo-policy" {
  repository = aws_ecr_repository.demo-repo.name

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
          "tagStatus": "tagged",
          "tagPrefixList": [
            "flask-demo-"
          ]
        },
        "description": "Keep last 2 flask-demo images ",
        "rulePriority": 1
      }
    ]
  }
      EOF

}