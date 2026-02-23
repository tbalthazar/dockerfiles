#!/bin/bash

# Script to run Claude Code in a Docker container
# Usage: ./run-claude.sh /path/to/project

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if project path argument is provided
if [ -z "$1" ]; then
    echo -e "${RED}Error: No project path provided${NC}"
    echo "Usage: $0 /path/to/project"
    exit 1
fi

PROJECT_PATH=$(realpath "$1")

# Verify project path exists
if [ ! -d "$PROJECT_PATH" ]; then
    echo -e "${RED}Error: Project path does not exist: $PROJECT_PATH${NC}"
    exit 1
fi

# Claude credentials directory (standard location)
CLAUDE_CONFIG_DIR="$HOME/.claude"

# Create Claude config directory if it doesn't exist
if [ ! -d "$CLAUDE_CONFIG_DIR" ]; then
    echo -e "${YELLOW}Creating Claude config directory at $CLAUDE_CONFIG_DIR${NC}"
    mkdir -p "$CLAUDE_CONFIG_DIR"
fi

# Create a stable machine-id for the container (persisted on host so OAuth tokens survive restarts)
MACHINE_ID_FILE="$CLAUDE_CONFIG_DIR/machine-id"
if [ ! -f "$MACHINE_ID_FILE" ]; then
    cat /proc/sys/kernel/random/uuid | tr -d '-' > "$MACHINE_ID_FILE"
    echo -e "${YELLOW}Created stable machine-id for container${NC}"
fi

# ~/.claude.json (in home root, not inside ~/.claude/) holds onboarding state, OAuth account,
# theme, and other top-level config — must be persisted separately
CLAUDE_JSON_FILE="$HOME/.claude.json"
if [ ! -f "$CLAUDE_JSON_FILE" ]; then
    echo "{}" > "$CLAUDE_JSON_FILE"
fi

# Docker image and container names (single container for all projects)
IMAGE_NAME="claude-code-dev"
CONTAINER_NAME="claude-dev"

# Check if Docker image exists, if not build it
if ! docker image inspect "$IMAGE_NAME" >/dev/null 2>&1; then
    echo -e "${YELLOW}Docker image not found. Building $IMAGE_NAME...${NC}"
    
    # Check if Dockerfile exists in current directory
    if [ ! -f "Dockerfile" ]; then
        echo -e "${RED}Error: Dockerfile not found in current directory${NC}"
        echo "Please make sure Dockerfile is in the same directory as this script"
        exit 1
    fi
    
    docker build -t "$IMAGE_NAME" .
    echo -e "${GREEN}Docker image built successfully${NC}"
fi

echo -e "${GREEN}Starting Claude Code container${NC}"
echo -e "Project path: ${GREEN}$PROJECT_PATH${NC}"
echo -e "Claude config: ${GREEN}$CLAUDE_CONFIG_DIR${NC}"

# Always use docker run with --rm to auto-cleanup
# This ensures we get a fresh container each time with the correct mounts
docker run -it --rm \
    --name "$CONTAINER_NAME" \
    -v "$PROJECT_PATH:/workspace:rw" \
    -v "$CLAUDE_CONFIG_DIR:/home/user/.claude:rw" \
    -v "$CLAUDE_JSON_FILE:/home/user/.claude.json:rw" \
    -v "$MACHINE_ID_FILE:/etc/machine-id:ro" \
    -w /workspace \
    "$IMAGE_NAME"

echo -e "${GREEN}Container session ended${NC}"
