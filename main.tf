# Create a VPC
module "vpc" {
  source      = "./modules/vpc"
  name_prefix = var.name_prefix
  aws_region  = var.aws_region
}

# Create an API running on an ECS Cluster
module "ecs" {
  source                    = "./modules/ecs"
  aws_region                = var.aws_region
  aws_profile               = var.aws_profile
  name_prefix               = var.name_prefix
  vpc_id                    = module.vpc.vpc_id
  public_subnet             = module.vpc.public_subnet
  private_subnet            = module.vpc.private_subnet
  scan_docker_image_on_push = var.scan_docker_image_on_push
}

# Advance ECS Demo: Service discovery, environment variables, and secrets
module "advance_demo" {
  source = "./modules/advance_demo"
  count                     = var.DeployThisModule ? 1 : 0
  aws_region                = var.aws_region
  aws_profile               = var.aws_profile
  name_prefix               = var.name_prefix
  scan_docker_image_on_push = var.scan_docker_image_on_push
  ecs_iam_role_arn          = module.ecs.ecs_iam_role_arn
  ecs_cluster_id            = module.ecs.ecs_cluster_id
  DB_USERNAME               = var.DB_USERNAME
  DB_PASSWORD               = var.DB_PASSWORD
  vpc_id                    = module.vpc.vpc_id
  vpc_cidr                  = module.vpc.vpc_cidr
  public_subnet             = module.vpc.public_subnet
  private_subnet            = module.vpc.private_subnet

  depends_on = [
    module.ecs
  ]
}