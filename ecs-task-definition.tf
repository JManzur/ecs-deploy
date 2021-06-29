#Load the task definition template from a json.tpl file
data "template_file" "flask-demo-tpl" {
  template = file("${var.templates_path}/flask-demo.json.tpl")

  vars = {
    app_image  = var.app_image
    aws_region = var.aws_region
    app_port   = var.app_port
  }
}

#Task definition
resource "aws_ecs_task_definition" "flask-demo-td" {
  family                   = "flask-demo-td"
  task_role_arn            = aws_iam_role.jm-ecs-role.arn
  execution_role_arn       = aws_iam_role.jm-ecs-role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.flask-demo-tpl.rendered

  tags = merge(var.demo_tags, { Name = "${var.tag_project}-flask-td" }, )
}

#Service definition
resource "aws_ecs_service" "flask-demo-service" {
  name                   = "flask-demo-service"
  cluster                = aws_ecs_cluster.demo-cluster.id
  task_definition        = aws_ecs_task_definition.flask-demo-td.arn
  desired_count          = var.app_count
  launch_type            = "FARGATE"
  enable_execute_command = true

  tags = merge(var.demo_tags, { Name = "${var.tag_project}-flask-srv" }, )

  network_configuration {
    security_groups = [aws_security_group.ecs_tasks.id]
    #fetched by vpc.tf
    subnets          = [for i in data.aws_subnet.private : i.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.flask-demo-tg.id
    container_name   = "flask-demo"
    container_port   = var.app_port
  }

  depends_on = [aws_alb_listener.flask-demo-front_end]
}