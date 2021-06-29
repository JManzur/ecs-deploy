##CloudWatch log group [15 days retention]
resource "aws_cloudwatch_log_group" "fd-log_group" {
  name              = "/ecs/flask-demo"
  retention_in_days = 15

  tags = merge(var.demo_tags, { Name = "${var.tag_project}-flask-lg" }, )
}

##CloudWatch log stream 
resource "aws_cloudwatch_log_stream" "fd_log_stream" {
  name           = "fd-log-stream"
  log_group_name = aws_cloudwatch_log_group.fd-log_group.name

  tags = merge(var.demo_tags, { Name = "${var.tag_project}-flask-ls" }, )
}