# Create an "IAM role" for ECS "Tasks Definition" with an inline policy that allow read parameter from System Manager
resource "aws_iam_role" "jm-ecs-role" {
  name               = "jm-ecs-role"
  assume_role_policy = file("${var.policy_path}/jm-ecs-role.json")
  tags               = merge(var.demo_tags, { Name = "${var.tag_project}-role" }, )

  inline_policy {
    name   = "allow-getsmparameter"
    policy = file("${var.policy_path}/sm-inline-policy.json")
  }
}

# ECS task execution role policy attachment
resource "aws_iam_role_policy_attachment" "jm-ecs-role" {
  role       = aws_iam_role.jm-ecs-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}