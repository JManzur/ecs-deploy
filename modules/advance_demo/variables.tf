variable "name-prefix" {}
variable "aws_region" {}
variable "aws_profile" {}
variable "scan_docker_image_on_push" {}
variable "ecs_iam_role_arn" {}
variable "ecs_cluster_id" {}
variable "DB_USERNAME" {}
variable "DB_PASSWORD" {}
variable "database" {}
variable "public_subnet" {}
variable "private_subnet" {}
variable "vpc_id" {}
variable "vpc_cidr" {}

variable "db_connection_test" {
  type = map(string)
  default = {
    "name"        = "db_connection_test"
    "port"        = 8048
    "cpu"         = 1024
    "memory"      = 2048
    "healthcheck" = "/status"
  }
}