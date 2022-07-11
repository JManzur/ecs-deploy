output "database_endpoint" {
  value = aws_db_instance.mysql.endpoint
}

output "db_connection_test_lb_dns" {
  value = "http://${aws_lb.db_connection_test.dns_name}:${var.db_connection_test["port"]}"
}

output "db_parameters_arn" {
  value = [
    "${aws_ssm_parameter.db_endpoint.arn}",
    "${aws_ssm_parameter.db_port.arn}",
    "${aws_ssm_parameter.db_name.arn}",
    "${aws_ssm_parameter.db_username.arn}",
    "${aws_ssm_parameter.db_password.arn}",
  ]
}