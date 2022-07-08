resource "aws_db_instance" "default" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0.29"
  instance_class       = "db.t3.micro"
  name                 = "pocdb"
  username             = var.db_username
  password             = var.db_password
  skip_final_snapshot  = true
}