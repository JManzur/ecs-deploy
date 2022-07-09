resource "aws_db_instance" "mysql" {
  identifier                 = var.database["identifier"]
  allocated_storage          = var.database["storage"]
  engine                     = var.database["engine"]
  engine_version             = var.database["version"]
  instance_class             = var.database["class"]
  db_name                    = var.database["name"]
  port                       = var.database["port"]
  username                   = var.DB_USERNAME
  password                   = var.DB_PASSWORD
  skip_final_snapshot        = true
  multi_az                   = false
  publicly_accessible        = false
  auto_minor_version_upgrade = true
  vpc_security_group_ids     = [aws_security_group.mysql.id]
  db_subnet_group_name       = aws_db_subnet_group.mysql.name
}

resource "aws_db_subnet_group" "mysql" {
  name       = var.database["subnet_group"]
  subnet_ids = [var.private_subnet[0], var.private_subnet[1]]
}