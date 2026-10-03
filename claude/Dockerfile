FROM debian:bookworm-slim

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    git \
    curl \
    ca-certificates \
    libgcc-s1 \
    libstdc++6 \
    npm \
    bash \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user with a proper home directory
RUN useradd -m -s /bin/bash tb

# Switch to the user and install Claude Code
USER tb
WORKDIR /home/tb

# Install Claude Code - the script will create ~/.local/bin automatically
RUN curl -fsSL https://claude.ai/install.sh | bash

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Install ansible-lint (pulls in ansible-core) as a uv tool.
# The tool venv and its Python live outside ~/.local/share/uv, which is
# mounted from the host at runtime and would otherwise shadow them.
RUN UV_TOOL_DIR=/home/tb/.local/opt/uv-tools \
    UV_PYTHON_INSTALL_DIR=/home/tb/.local/opt/uv-python \
    /home/tb/.local/bin/uv tool install ansible-lint

# Verify installation
RUN ls -la /home/tb/.local/bin/ && \
    test -f /home/tb/.local/bin/claude && \
    echo "Claude binary found successfully" && \
    /home/tb/.local/bin/ansible-lint --version

# Add user's .local/bin to PATH, plus the ansible-lint venv so ansible-lint
# finds ansible-playbook and friends without warning
ENV PATH="/home/tb/.local/bin:/home/tb/.local/opt/uv-tools/ansible-lint/bin:${PATH}"

# Set working directory
WORKDIR /workspace

# Run as user (simpler and more secure)
CMD ["claude"]
