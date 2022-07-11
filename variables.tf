variable "aws_region" {
  type    = string
  default = ""
}

variable "aws_profile" {
  type    = string
  default = ""
}

/* Tags Variables */
variable "project-tags" {
  type = map(string)
  default = {
    Service     = "ECS-POC",
    Environment = "POC",
    DeployedBy  = "JManzur - https://jmanzur.com"
  }
}

#Usage: tags = { Name = "${var.name_prefix}-lambda" }
variable "name_prefix" {
  type    = string
  default = "ECS"
}

variable "DeployThisModule" {
  type    = bool
  default = true
  description = "If set to false, the module will not be deployed"
}

variable "scan_docker_image_on_push" {
  type    = bool
  default = false
  description = "Ref: https://docs.aws.amazon.com/AmazonECR/latest/userguide/image-scanning.html"
}

/* Variables from .env file: */

variable "DB_USERNAME" {}
variable "DB_PASSWORD" {}