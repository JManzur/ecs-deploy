output "database_endpoint" {
  value = aws_db_instance.mysql.endpoint
}

output "db_connection_test_lb_dns" {
  value = "http://${aws_lb.db_connection_test.dns_name}:${var.db_connection_test["port"]}"
}