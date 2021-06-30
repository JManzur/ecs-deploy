#Deploy VPC using AWS VPC Module 
#Registry: https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest

### IMPORTANT: Run this module FIRST by using: "terraform apply -target=module.vpc" ###

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "demo-vpc"
  cidr = "20.10.0.0/16"

  #AZ's and Subnets Definition
  azs              = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  private_subnets  = ["20.10.1.0/24", "20.10.2.0/24", "20.10.3.0/24"]
  public_subnets   = ["20.10.11.0/24", "20.10.12.0/24", "20.10.13.0/24"]
  database_subnets = ["20.10.21.0/24", "20.10.22.0/24", "20.10.23.0/24"]
  intra_subnets    = ["20.10.31.0/24", "20.10.32.0/24", "20.10.33.0/24"]

  tags                 = merge(var.demo_tags, { Name = "${var.tag_project}-vpc" }, )
  database_subnet_tags = merge(var.demo_tags, { Name = "${var.tag_project}-db_subnet" }, )
  private_subnet_tags  = merge(var.demo_tags, { Name = "${var.tag_project}-private_subnet" }, )
  public_subnet_tags   = merge(var.demo_tags, { Name = "${var.tag_project}-public_subnet" }, )
  intra_subnet_tags    = merge(var.demo_tags, { Name = "${var.tag_project}-intra_subnet" }, )

  #Deny Access to DB subnet form public subnet
  create_database_subnet_group = false

  #Routing tables 
  manage_default_route_table = true

  default_route_table_tags  = merge(var.demo_tags, { Name = "${var.tag_project}-rt" }, )
  private_route_table_tags  = merge(var.demo_tags, { Name = "${var.tag_project}-private_rt" }, )
  public_route_table_tags   = merge(var.demo_tags, { Name = "${var.tag_project}-public_rt" }, )
  database_route_table_tags = merge(var.demo_tags, { Name = "${var.tag_project}-db_rt" }, )
  intra_route_table_tags    = merge(var.demo_tags, { Name = "${var.tag_project}-intra_rt" }, )

  #Nat Gateway
  enable_nat_gateway = true
  single_nat_gateway = true

  nat_gateway_tags = merge(var.demo_tags, { Name = "${var.tag_project}-ng" }, )

  #Deny all SG:
  manage_default_security_group  = true
  default_security_group_ingress = []
  default_security_group_egress  = []

  default_security_group_tags = merge(var.demo_tags, { Name = "${var.tag_project}-vpc-sg" }, )

  #VPC Flow Logs 
  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  flow_log_max_aggregation_interval    = 60

  vpc_flow_log_tags = merge(var.demo_tags, { Name = "${var.tag_project}-vpc_logs" }, )
}

## Data Sources declarations ##
## Fetch the vpc id to print and use the output
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["demo-vpc"]
  }
}

## Fetch the public subnets ids to print and use the output
data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.selected.id

  filter {
    name   = "tag:Name"
    values = ["demo-public_subnet"]
  }
}

data "aws_subnet" "public" {
  for_each = data.aws_subnet_ids.public.ids
  id       = each.value
}

## Fetch the privates subnets ids to print and use the output
data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.selected.id

  filter {
    name   = "tag:Name"
    values = ["demo-private_subnet"]
  }
}

data "aws_subnet" "private" {
  for_each = data.aws_subnet_ids.private.ids
  id       = each.value
}