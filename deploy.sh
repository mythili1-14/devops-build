#!/bin/bash

REPO_TYPE=$1  # e.g., "prod" or "dev"
TAG=$2        # e.g., "main" or "dev"

IMAGE_NAME="mythili121/devops-build-${REPO_TYPE}:${TAG}"

echo "Pulling the latest Docker image: $IMAGE_NAME"
docker pull $IMAGE_NAME


echo "Stopping and removing existing container (if any)..."
docker stop devops-app || true
docker rm devops-app || true


echo "Starting a new container..."
docker run -d --name devops-app -p 80:80 $IMAGE_NAME

echo "Deployment complete."
