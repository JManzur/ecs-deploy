variable "scan_docker_image_on_push" {}
variable "DB_USERNAME" {}
variable "DB_PASSWORD" {}
variable "database" {}
variable "private_subnet" {}
variable "vpc_id" {}
variable "vpc_cidr" {}

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