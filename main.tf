# Create a VPC
module "vpc" {
  source      = "./modules/vpc"
  name-prefix = var.name-prefix
  aws_region  = var.aws_region
}

# Create an API running on an ECS Cluster
module "ecs" {
  source                    = "./modules/ecs"
  aws_region                = var.aws_region
  aws_profile               = var.aws_profile
  name-prefix               = var.name-prefix
  vpc_id                    = module.vpc.vpc_id
  public_subnet             = module.vpc.public_subnet
  private_subnet            = module.vpc.private_subnet
  scan_docker_image_on_push = var.scan_docker_image_on_push
}

module "advance_demo" {
  source = "./modules/advance_demo"
  #count                     = var.DeployThisModule ? 1 : 0
  aws_region                = var.aws_region
  aws_profile               = var.aws_profile
  name-prefix               = var.name-prefix
  scan_docker_image_on_push = var.scan_docker_image_on_push
  ecs_iam_role_arn          = module.ecs.ecs_iam_role_arn
  ecs_cluster_id            = module.ecs.ecs_cluster_id
  database                  = var.database
  DB_USERNAME               = var.DB_USERNAME
  DB_PASSWORD               = var.DB_PASSWORD
  public_subnet             = module.vpc.public_subnet
  private_subnet            = module.vpc.private_subnet
  vpc_id                    = module.vpc.vpc_id
  vpc_cidr                  = module.vpc.vpc_cidr
}