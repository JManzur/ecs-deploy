/* Variables from module: */

variable "aws_region" {}
variable "aws_profile" {}
variable "name_prefix" {}
variable "scan_docker_image_on_push" {}
variable "ecs_iam_role_arn" {}
variable "ecs_cluster_id" {}
variable "DB_USERNAME" {}
variable "DB_PASSWORD" {}
variable "vpc_id" {}
variable "vpc_cidr" {}
variable "public_subnet" {}
variable "private_subnet" {}

/* Locals variables: */

variable "database" {
  type = map(any)
  default = {
    "port"         = 3306,
    "identifier"   = "mysqlpoc",
    "engine"       = "mysql",
    "version"      = "8.0",
    "class"        = "db.t3.micro",
    "name"         = "pocdb",
    "storage"      = 20,
    "subnet_group" = "mysql_subnet_group"
  }
}

variable "db_connection_test" {
  type = map(any)
  default = {
    "name"        = "db_connection_test",
    "port"        = 8048,
    "cpu"         = 1024,
    "memory"      = 2048,
    "healthcheck" = "/status"
  }
}

variable "dummy_backend" {
  type = map(any)
  default = {
    "name"        = "dummy_backend",
    "port"        = 8049,
    "cpu"         = 1024,
    "memory"      = 2048,
    "healthcheck" = "/status"
  }
}