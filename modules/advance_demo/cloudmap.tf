#Provides a Service Discovery Private DNS Namespace resource
resource "aws_service_discovery_private_dns_namespace" "apps" {
  name        = "app"
  vpc         = var.vpc_id
  description = "App Discovery Managed Zone"
  tags        = { Name = "${var.name-prefix}-DNS" }
}

#Provides a Service Discovery Service resource:
resource "aws_service_discovery_service" "apps" {
  for_each = toset([
    "${var.db_connection_test["name"]}"
  ])

  name = each.key
  dns_config {
    namespace_id   = aws_service_discovery_private_dns_namespace.apps.id
    routing_policy = "MULTIVALUE"

    dns_records {
      ttl  = 300
      type = "A"
    }

    dns_records {
      ttl  = 300
      type = "SRV"
    }
  }

  health_check_custom_config {
    failure_threshold = 5
  }

  tags = { Name = "${each.key}-discovery-service" }
}
