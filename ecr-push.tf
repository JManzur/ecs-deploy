### IMPORTANT: Run this module after the ECR deploymen by using: "terraform apply -target=null_resource.push" ###

# Equivalent to 'aws ecr get-login'
data "aws_ecr_authorization_token" "ecr_token" {}

# Calculate hash of the Docker image source contents
data "external" "hash" {
  program = [coalesce("${var.scripts_path}/hash.sh"), var.source_path]
}

# Capture correct timestamp from bash file - used instead of terraform timestamp()
data "external" "time_stamp" {
  program = [coalesce("${var.scripts_path}/time_stamp.sh")]
}

# Make a "docker build" and "docker push" if the hash of the Dockerfile directory change.
resource "null_resource" "push" {
  triggers = {
    hash = data.external.hash.result["hash"]
  }

  provisioner "local-exec" {
    command     = "${coalesce("${var.scripts_path}/push.sh")} ${var.source_path} ${aws_ecr_repository.demo-repo.repository_url} flask-demo-${data.external.time_stamp.result["time_stamp"]}"
    interpreter = ["bash", "-c"]
  }
}