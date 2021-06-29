## SG Rule: Internet > ALB
resource "aws_security_group" "flask-demo-sg" {
  name        = "flask-demo-sg"
  description = "Allow public access to the ALB"
  vpc_id      = data.aws_vpc.selected.id

  tags = merge(var.demo_tags, { Name = "${var.tag_project}-toalb-sg" }, )

  ingress {
    protocol    = "tcp"
    from_port   = var.app_port
    to_port     = var.app_port
    cidr_blocks = ["0.0.0.0/0"]
    description = "Internet to ALB"
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

## SG Rule: ALB > ECS
resource "aws_security_group" "ecs_tasks" {
  name        = "flask_demo-ecs-tasks-security-group"
  description = "Allow ALB to ECS ONLY"
  vpc_id      = data.aws_vpc.selected.id

  tags = merge(var.demo_tags, { Name = "${var.tag_project}-toecs-sg" }, )

  ingress {
    protocol        = "tcp"
    from_port       = var.app_port
    to_port         = var.app_port
    security_groups = [aws_security_group.flask-demo-sg.id]
    description     = "Flask ALB to ECS"
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}