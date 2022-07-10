output "demo_app_alb_dns" {
  value = "http://${aws_lb.demo_app_alb.dns_name}:${var.demo_app["port"]}"
}

output "ecs_iam_role_arn" {
  value = aws_iam_role.ecs_role.arn
}

output "ecs_cluster_id" {
  value = aws_ecs_cluster.demo_cluster.id
}