#!/bin/bash

set -eu

echo "--- :docker: Building docker image"

TAG="${BUILDKITE_BUILD_NUMBER}"

docker build -t "$ECR_REPO:$TAG" --build-arg="DD_RUM_VERSION=$BUILDKITE_BUILD_NUMBER" --build-arg="DD_RUM_VERSION=production" .

echo "--- :docker: Pushing docker image"

docker push "$ECR_REPO:$TAG"
