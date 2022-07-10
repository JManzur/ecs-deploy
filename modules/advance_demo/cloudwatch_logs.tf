##CloudWatch log group [30 days retention]
resource "aws_cloudwatch_log_group" "db_connection_test" {
  name              = "/ecs/db_connection_test_logs"
  retention_in_days = 30

  tags = { Name = "${var.name-prefix}-Demo-App-logs" }
}

##CloudWatch log stream 
resource "aws_cloudwatch_log_stream" "db_connection_test" {
  name           = "db_connection_test_logs_stream"
  log_group_name = aws_cloudwatch_log_group.db_connection_test.name
}