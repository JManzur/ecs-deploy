resource "aws_ssm_parameter" "db_endpoint" {
  name        = "/poc/database/credentials/endpoint"
  description = "The database endpoint"
  type        = "SecureString"
  value       = split(":", "${aws_db_instance.mysql.endpoint}")[0]

  depends_on = [
    aws_db_instance.mysql
  ]
}

resource "aws_ssm_parameter" "db_port" {
  name        = "/poc/database/credentials/port"
  description = "The database port"
  type        = "SecureString"
  value       = split(":", "${aws_db_instance.mysql.endpoint}")[1]

  depends_on = [
    aws_db_instance.mysql
  ]
}

resource "aws_ssm_parameter" "db_username" {
  name        = "/poc/database/credentials/username"
  description = "The database username"
  type        = "SecureString"
  value       = var.DB_USERNAME

  depends_on = [
    aws_db_instance.mysql
  ]
}

resource "aws_ssm_parameter" "db_password" {
  name        = "/poc/database/credentials/password"
  description = "The database password"
  type        = "SecureString"
  value       = var.DB_PASSWORD

  depends_on = [
    aws_db_instance.mysql
  ]
}

resource "aws_ssm_parameter" "db_name" {
  name        = "/poc/database/credentials/db_name"
  description = "The database name"
  type        = "SecureString"
  value       = var.database["name"]

  depends_on = [
    aws_db_instance.mysql
  ]
}