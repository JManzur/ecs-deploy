#Provides a Service Discovery Private DNS Namespace resource
resource "aws_service_discovery_private_dns_namespace" "apps" {
  name        = "app"
  vpc         = var.workload_vpc_id
  description = "App Discovery managed zone."
  tags        = { Name = "${var.ECSTagPrefix}-DNS" }
}

#Provides a Service Discovery Service resource:
resource "aws_service_discovery_service" "apps" {
  for_each = {
    "app1" = "optimal-power-flow"
    "app2" = "service-circuit-mgt"
    "app3" = "service-device-comm"
    "app4" = "service-topology"
    "app5" = "service-vopf-mgmnt"
    "app6" = "service-vopf"
    "app7" = "signal-warehouse"
    "app8" = "simulator-dnp3"
  }
  name = each.value
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

  tags = { Name = "${each.value}-discovery-service" }
}
