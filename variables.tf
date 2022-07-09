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

#Usage: tags = { Name = "${var.name-prefix}-lambda" }
variable "name-prefix" {
  type    = string
  default = "ECS-POC"
}

variable "DeployThisModule" {
  type    = bool
  default = false
}

variable "scan_docker_image_on_push" {
  type    = bool
  default = false
}

variable "DB_USERNAME" {}

variable "DB_PASSWORD" {}

#Use: var.engine["engine"]
variable "database" {
  type = map(any)
  default = {
    "port"         = 3306,
    "identifier"   = "mysqlpoc",
    "engine"       = "mysql",
    "version"      = "8.0.29",
    "class"        = "db.t3.micro",
    "name"         = "pocdb",
    "storage"      = 20,
    "subnet_group" = "mysql_subnet_group"
  }
}