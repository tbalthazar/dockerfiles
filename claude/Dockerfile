FROM debian:bookworm-slim

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    git \
    curl \
    ca-certificates \
    libgcc-s1 \
    libstdc++6 \
    bash \
    npm \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install pyright globally (as root)
RUN npm install -g pyright

# Create a non-root user with a proper home directory
RUN useradd -m -s /bin/bash tb

# Switch to the user and install Claude Code
USER tb
WORKDIR /home/tb

# Install Claude Code - the script will create ~/.local/bin automatically
RUN curl -fsSL https://claude.ai/install.sh | bash

# Verify installation
RUN ls -la /home/tb/.local/bin/ && \
    test -f /home/tb/.local/bin/claude && \
    echo "Claude binary found successfully"

# Add user's .local/bin to PATH
ENV PATH="/home/tb/.local/bin:${PATH}"

# Set working directory
WORKDIR /workspace

# Run as user (simpler and more secure)
CMD ["claude"]
