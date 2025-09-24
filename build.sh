#!/bin/bash


BRANCH=${BRANCH_NAME}

if [ "$BRANCH" == "main" ]; then
    REPO_NAME="mythili121/devops-build-prod"
elif [ "$BRANCH" == "dev" ]; then
    REPO_NAME="mythili121/devops-build-dev"
else
    echo "Not a recognized branch (dev or main). Exiting."
    exit 1
fi

echo "Building Docker image for branch: $BRANCH"
docker build -t $REPO_NAME:$BRANCH .

echo "Pushing image to Docker Hub repository: $REPO_NAME"
docker push $REPO_NAME:$BRANCH

echo "Docker image build and push complete."
