## ECR and docker images tagging output
output "ecr_arn" {
  value       = aws_ecr_repository.demo-repo.arn
  description = "Full ARN of the repository"
}

output "ecr_name" {
  value       = aws_ecr_repository.demo-repo.name
  description = "Name of the repository"
}

output "ecr_registry_id" {
  value       = aws_ecr_repository.demo-repo.registry_id
  description = "Registry ID where the repository was created"
}

output "ecr_repository_url" {
  value       = aws_ecr_repository.demo-repo.repository_url
  description = "URL of the repository"
}

output "image-hash" {
  value       = data.external.hash.result["hash"]
  description = "Docker image source hash"
}

output "timestamp-tag" {
  value       = data.external.time_stamp.result["time_stamp"]
  description = "Print the time stamp used for tagging"
}

output "image_uri" {
  value       = "${aws_ecr_repository.demo-repo.repository_url}:flask-demo-${data.external.time_stamp.result["time_stamp"]}"
  description = "Image URI Output formation"
}

##ECS output
output "ecs-arn" {
  value       = aws_ecs_cluster.demo-cluster.arn
  description = "Full ARN of the Cluster"
}

output "ecs-name" {
  value       = aws_ecs_cluster.demo-cluster.name
  description = "Full name of the Cluster"
}

output "ecs-id" {
  value       = aws_ecs_cluster.demo-cluster.id
  description = "Cluster ID where it was created"
}

output "ecs-role-arn" {
  value       = aws_iam_role.jm-ecs-role.arn
  description = "IAM Role ARN created by roles.tf"
}

##VPC output
output "vpc-id" {
  value       = data.aws_vpc.selected.id
  description = "Print the VPC ID fetched by vpc.tf"
}

output "public_subnet_ids" {
  value       = [for i in data.aws_subnet.public : i.id]
  description = "Print the public subnets id fetched by vpc.tf"
}

output "private_subnet_ids" {
  value       = [for i in data.aws_subnet.private : i.id]
  description = "Print the private subnets id fetched by vpc.tf"
}

output "flask-alb-dns" {
  value       = "http://${aws_alb.flask-demo-alb.dns_name}:5000"
  description = "Final DNS to access the app"
}