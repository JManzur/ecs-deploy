output "demo_app_alb_dns" {
  value       = module.ecs.demo_app_alb_dns
  description = "The Demo APP ALB FQDN"
}

output "db_connection_test_lb_dns" {
  value       = module.advance_demo[0].db_connection_test_lb_dns
  description = "The DB Connection Test ALB FQDN"
}

output "database_endpoint" {
  value       = module.advance_demo[0].database_endpoint
  description = "The Database connection endpoint"
}

output "db_parameters_arn" {
  value       = module.advance_demo[0].db_parameters_arn
    description = "The DB Database Parameters ARN"
}