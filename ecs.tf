# Elastic Container Service Definition
resource "aws_ecs_cluster" "demo-cluster" {
  name               = "demo-cluster"
  capacity_providers = ["FARGATE_SPOT", "FARGATE"]
  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
  }
  tags = merge(var.demo_tags, { Name = "${var.tag_project}-cluster" }, )
}