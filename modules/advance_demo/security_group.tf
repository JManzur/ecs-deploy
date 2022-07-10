## SG Rule: VPC > RDS
resource "aws_security_group" "mysql" {
  name        = "mysql_sg"
  description = "Allow public access to the ALB"
  vpc_id      = var.vpc_id
  tags        = { Name = "VPC-To-RDS" }

  ingress {
    protocol    = "tcp"
    from_port   = var.database["port"]
    to_port     = var.database["port"]
    cidr_blocks = ["0.0.0.0/0"]
    description = "From VPC to RDS"
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "http" "myip" {
  url = "https://ifconfig.co/"
}

## SG Rule: Form User IP > ALB
resource "aws_security_group" "db_connection_test_alb" {
  name        = "db_connection_test_alb"
  description = "Form User IP to the ALB"
  vpc_id      = var.vpc_id
  tags        = { Name = "${var.name-prefix}-Form-User-IP-To-ALB" }

  ingress {
    protocol    = "tcp"
    from_port   = var.db_connection_test["port"]
    to_port     = var.db_connection_test["port"]
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
    description = "Form User IP"
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

## SG Rule: ALB > DB Connection Test
resource "aws_security_group" "db_connection_test" {
  name        = "db_connection_test_sg"
  description = "Allow ALB to DB Connection Test ONLY"
  vpc_id      = var.vpc_id
  tags        = { Name = "${var.name-prefix}-ALB-To-DB-Connection-Test" }

  ingress {
    protocol        = "tcp"
    from_port       = var.db_connection_test["port"]
    to_port         = var.db_connection_test["port"]
    security_groups = [aws_security_group.db_connection_test_alb.id]
    description     = "ALB to DB Connection Test"
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}