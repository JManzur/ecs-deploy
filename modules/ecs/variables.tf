/* Variables from module: */

variable "aws_region" {}
variable "aws_profile" {}
variable "name_prefix" {}
variable "vpc_id" {}
variable "public_subnet" {}
variable "private_subnet" {}
variable "scan_docker_image_on_push" {}

/* Locals variables: */

variable "demo_app" {
  type = map(any)
  default = {
    "name"        = "demo_flask_app",
    "port"        = 8082,
    "cpu"         = 1024,
    "memory"      = 2048,
    "healthcheck" = "/status"
  }
}