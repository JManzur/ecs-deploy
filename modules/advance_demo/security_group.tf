/* Database Connection test app */ 

## SG Rule: VPC > RDS
resource "aws_security_group" "mysql" {
  name        = "mysql_sg"
  description = "Allow access to RDS from the VPC"
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
  tags        = { Name = "${var.name_prefix}-Form-User-IP-To-ALB" }

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
  tags        = { Name = "${var.name_prefix}-ALB-To-DB-Connection-Test" }

  ingress {
    protocol        = "tcp"
    from_port       = var.db_connection_test["port"]
    to_port         = var.db_connection_test["port"]
    security_groups = [aws_security_group.db_connection_test_alb.id]
    description     = "ALB to DB Connection Test"
  }

  ingress {
    description = "Allow PING"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

/* Dummy Backend app */ 

## SG Rule: VPC > Dummy Backend app
resource "aws_security_group" "dummy_backend" {
  name        = "dummy_backend_sg"
  description = "Allow access to the Dummy Backend app from VPC"
  vpc_id      = var.vpc_id
  tags        = { Name = "VPC-To-DummyBackend" }

  ingress {
    protocol    = "tcp"
    from_port   = var.dummy_backend["port"]
    to_port     = var.dummy_backend["port"]
    cidr_blocks = ["0.0.0.0/0"]
    description = "From VPC to Dummy Backend"
  }

  ingress {
    description = "Allow PING"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}