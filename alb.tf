#Application Load Balancer (ALB): Internet > Flask-Demo ECS
resource "aws_alb" "flask-demo-alb" {
  name               = "flask-demo-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.flask-demo-sg.id]
  subnets            = [for i in data.aws_subnet.public : i.id]

  tags = merge(var.demo_tags, { Name = "${var.tag_project}-alb" }, )
}

#ALB Target
resource "aws_alb_target_group" "flask-demo-tg" {
  name        = "flask-demo-tg"
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.selected.id
  target_type = "ip"

  tags = merge(var.demo_tags, { Name = "${var.tag_project}-tg" }, )

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }
}

#ALB Listener
resource "aws_alb_listener" "flask-demo-front_end" {
  load_balancer_arn = aws_alb.flask-demo-alb.id
  port              = var.app_port
  protocol          = "HTTP"

  tags = merge(var.demo_tags, { Name = "${var.tag_project}-listener" }, )

  default_action {
    target_group_arn = aws_alb_target_group.flask-demo-tg.id
    type             = "forward"
  }
}