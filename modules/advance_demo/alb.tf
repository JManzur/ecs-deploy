#Application Load Balancer (ALB): From User IP > DB Connection Test
resource "aws_lb" "db_connection_test" {
  name               = "db-connection-test-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.db_connection_test_alb.id]
  subnets            = [var.public_subnet[0], var.public_subnet[1]]

  tags = { Name = "${var.name_prefix}-DB-Connection-Test-ALB" }
}

#ALB Target
resource "aws_lb_target_group" "db_connection_test" {
  name        = "db-connection-test-tg"
  port        = var.db_connection_test["port"]
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  tags = { Name = "${var.name_prefix}-DB-Connection-Test-TG" }

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.db_connection_test["healthcheck"]
    unhealthy_threshold = "2"
  }
}

#ALB Listener
resource "aws_lb_listener" "db_connection_test" {
  load_balancer_arn = aws_lb.db_connection_test.id
  port              = var.db_connection_test["port"]
  protocol          = "HTTP"

  tags = { Name = "${var.name_prefix}-DB-Connection-Test-Listener" }

  default_action {
    target_group_arn = aws_lb_target_group.db_connection_test.id
    type             = "forward"
  }
}