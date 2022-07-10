variable "name-prefix" {}
variable "aws_region" {}
variable "aws_profile" {}
variable "vpc_id" {}
variable "public_subnet" {}
variable "private_subnet" {}
variable "scan_docker_image_on_push" {}

variable "demo_app" {
  type = map(string)
  default = {
    "name"        = "demo_flask_app"
    "port"        = 8082
    "cpu"         = 1024
    "memory"      = 2048
    "healthcheck" = "/status"
  }
}