/* Buil and push to ECR */

# Equivalent to 'aws ecr get-login'
data "aws_ecr_authorization_token" "ecr_token" {}

# Make a "docker build" and "docker push" if the hash of the Dockerfile directory change.
resource "null_resource" "push" {
  triggers = { always_run = "${timestamp()}" }

  provisioner "local-exec" {
    command = "echo ${data.aws_ecr_authorization_token.ecr_token.password}"
  }

  provisioner "local-exec" {
    #{push.sh} {aws_region} {aws_profile} {SOURCE_CODE} {ECR_URL} {IMAGE_TAG}
    command     = "${coalesce("${path.root}/scripts/push.sh")} ${var.aws_region} ${var.aws_profile} ${path.module}/docker/db_connection_test ${aws_ecr_repository.db_connection_test.repository_url} latest"
    interpreter = ["bash", "-c"]
  }
}

#Load the task definition template from a json.tpl file
data "template_file" "db_connection_test_tpl" {
  template = file("${path.module}/templates/db_connection_test.json.tpl")

  vars = {
    app_name      = var.db_connection_test["name"]
    app_image     = aws_ecr_repository.db_connection_test.repository_url
    aws_region    = var.aws_region
    MYSQL_HOST    = aws_ssm_parameter.db_endpoint.arn
    MYSQL_PORT    = aws_ssm_parameter.db_port.arn
    MYSQL_DB      = aws_ssm_parameter.db_name.arn
    MYSQL_USER    = aws_ssm_parameter.db_username.arn
    MYSQL_PASSWD  = aws_ssm_parameter.db_password.arn
    app_port      = var.db_connection_test["port"]
    app_cw_group  = aws_cloudwatch_log_group.db_connection_test.name
    app_cw_stream = aws_cloudwatch_log_stream.db_connection_test.name
    cpu           = var.db_connection_test["cpu"]
    memory        = var.db_connection_test["memory"]
  }
}

#Task definition
resource "aws_ecs_task_definition" "db_connection_test_td" {
  family                   = var.db_connection_test["name"]
  task_role_arn            = var.ecs_iam_role_arn
  execution_role_arn       = var.ecs_iam_role_arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.db_connection_test["cpu"]
  memory                   = var.db_connection_test["memory"]
  container_definitions    = data.template_file.db_connection_test_tpl.rendered

  tags = { Name = "${var.name-prefix}-DB-Connection-Test-TD" }

  depends_on = [
    aws_db_instance.mysql
  ]
}

#Service definition
resource "aws_ecs_service" "db_connection_test_service" {
  name                   = var.db_connection_test["name"]
  cluster                = var.ecs_cluster_id
  task_definition        = aws_ecs_task_definition.db_connection_test_td.arn
  desired_count          = 2
  launch_type            = "FARGATE"
  platform_version       = "LATEST"
  enable_execute_command = true

  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100

  network_configuration {
    security_groups  = [aws_security_group.db_connection_test.id]
    subnets          = [var.private_subnet[0], var.private_subnet[1]]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.db_connection_test.id
    container_name   = var.db_connection_test["name"]
    container_port   = var.db_connection_test["port"]
  }

  tags = { Name = "${var.name-prefix}-Demo-App-Srv" }

  depends_on = [aws_lb_listener.db_connection_test]
}