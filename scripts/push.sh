#!/bin/bash
# Used by: ecr-push.tf
# Manual Use:
# $ ./push.sh . 123456789012.dkr.ecr.us-west-1.amazonaws.com/hello-world latest

set -e

source_path="$1"
repository_url="$2"
tag="${3:-latest}"

region="$(echo "$repository_url" | cut -d. -f4)"
image_name="$(echo "$repository_url" | cut -d/ -f2)"

(cd "$source_path" && DOCKER_BUILDKIT=0 docker build -t "$image_name" .)

aws ecr get-login-password --region "$region" | docker login --username AWS --password-stdin "$repository_url"
docker tag "$image_name" "$repository_url":"$tag"
docker push "$repository_url":"$tag"
