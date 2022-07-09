output "demo_app_alb_dns" {
  value       = module.ecs.demo_app_alb_dns
  description = "The Demo APP ALB FQDN"
}

output "database_endpoint" {
  value       = module.advance_demo.database_endpoint
  description = "The Database connection endpoint"
}