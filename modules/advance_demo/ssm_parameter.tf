resource "aws_ssm_parameter" "db_endpoint" {
  name        = "/poc/database/credentials/endpoint"
  description = "The database endpoint"
  type        = "SecureString"
  value       = split(":", "${aws_db_instance.mysql.endpoint}")[0]

  tags = { Database = "${aws_db_instance.mysql.arn}" }

  depends_on = [
    aws_db_instance.mysql
  ]
}

resource "aws_ssm_parameter" "db_port" {
  name        = "/poc/database/credentials/port"
  description = "The database port"
  type        = "SecureString"
  value       = split(":", "${aws_db_instance.mysql.endpoint}")[1]

  tags = { Database = "${aws_db_instance.mysql.arn}" }

  depends_on = [
    aws_db_instance.mysql
  ]
}

resource "aws_ssm_parameter" "db_username" {
  name        = "/poc/database/credentials/username"
  description = "The database username"
  type        = "SecureString"
  value       = var.DB_USERNAME

  tags = { Database = "${aws_db_instance.mysql.arn}" }
}

resource "aws_ssm_parameter" "db_password" {
  name        = "/poc/database/credentials/password"
  description = "The database password"
  type        = "SecureString"
  value       = var.DB_PASSWORD

  tags = { Database = "${aws_db_instance.mysql.arn}" }
}

resource "aws_ssm_parameter" "db_name" {
  name        = "/poc/database/credentials/db_name"
  description = "The database name"
  type        = "SecureString"
  value       = var.database["name"]

  tags = { Database = "${aws_db_instance.mysql.arn}" }
}