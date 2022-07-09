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
    cidr_blocks = [var.vpc_cidr]
    description = "From VPC to RDS"
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}