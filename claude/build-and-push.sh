#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

IMAGE_NAME="tbalthazar/claude-code-dev"

echo -e "${YELLOW}Building $IMAGE_NAME...${NC}"
docker build -t "$IMAGE_NAME" "$SCRIPT_DIR"
echo -e "${GREEN}Docker image built successfully${NC}"

echo -e "${YELLOW}Pushing $IMAGE_NAME to Docker Hub...${NC}"
docker push "$IMAGE_NAME"
echo -e "${GREEN}Docker image pushed successfully${NC}"
