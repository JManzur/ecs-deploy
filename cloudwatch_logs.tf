##CloudWatch log group [30 days retention]
resource "aws_cloudwatch_log_group" "fd-log_group" {
  name              = var.cw_group
  retention_in_days = 30

  tags = merge(var.demo_tags, { Name = "${var.tag_project}-flask-lg" }, )
}

##CloudWatch log stream 
resource "aws_cloudwatch_log_stream" "fd_log_stream" {
  name           = var.cw_stream
  log_group_name = aws_cloudwatch_log_group.fd-log_group.name
}