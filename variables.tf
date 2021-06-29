### Region
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

###  Tags Variables
variable "demo_tags" {
  type = map(string)
  default = {
    service     = "jm-demo",
    environment = "demo"
    owner       = "example@example.com"
  }
}

variable "tag_project" {
  type    = string
  default = "demo"
}

### Cloudwatch Variables:
variable "cw_group" {
  type    = string
  default = "/ecs/flask-demo"
}

variable "cw_stream" {
  type    = string
  default = "fd-log-stream"
}

### Path Variables:
variable "source_path" {
  type    = string
  default = "docker-demo"
}

variable "scripts_path" {
  type    = string
  default = "scripts"
}

variable "templates_path" {
  type    = string
  default = "templates"
}

variable "policy_path" {
  type    = string
  default = "iam-policy"
}

### Task Definition Variables:
variable "app_count" {
  description = "Number of docker containers to run"
  default     = 3
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}

variable "health_check_path" {
  default = "/status"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 5000
}

###IMPORTANT: Update this value after running "terraform apply -target=null_resource.push"
variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "036228551395.dkr.ecr.us-east-1.amazonaws.com/demo-repository:flask-demo-202106281342"
}