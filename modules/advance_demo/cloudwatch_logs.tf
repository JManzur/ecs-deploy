/* Database Connection test app */ 
resource "aws_cloudwatch_log_group" "db_connection_test" {
  name              = "/ecs/db_connection_test_logs"
  retention_in_days = 30

  tags = { Name = "${var.name_prefix}-Demo-App-logs" }
}

resource "aws_cloudwatch_log_stream" "db_connection_test" {
  name           = "db_connection_test_logs_stream"
  log_group_name = aws_cloudwatch_log_group.db_connection_test.name
}


/* Dummy Backend app */ 
resource "aws_cloudwatch_log_group" "dummy_backend" {
  name              = "/ecs/dummy_backend_logs"
  retention_in_days = 30

  tags = { Name = "${var.name_prefix}-Dummy-Backend-logs" }
}

resource "aws_cloudwatch_log_stream" "dummy_backend" {
  name           = "dummy_backend_logs_stream"
  log_group_name = aws_cloudwatch_log_group.dummy_backend.name
}