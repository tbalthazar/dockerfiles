# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A Docker-based setup for running Claude Code in an isolated container. The pre-built image is published to Docker Hub as `tbalthazar/claude-code-dev`.

A separate `claude-docker` launch script (in a separate repository) pulls and runs the image. It mounts the current directory into `/workspace`, `~/.claude/`, `~/.claude.json`, and `~/.gitconfig` into the container.

## Key files

- `Dockerfile` — defines the container image (Debian bookworm-slim, non-root user `tb`)
- `build-and-push.sh` — builds the image and pushes it to Docker Hub (maintainers only)

## Common commands

```bash
# Build and push the image to Docker Hub
./build-and-push.sh
```

## Architecture notes

### Container user
The container runs as user `tb`. All home-directory paths inside the container are `/home/tb/`. The `ENV PATH` line in the Dockerfile adds `/home/tb/.local/bin` to `PATH`, which is where Claude Code, `uv`, and `ruff` binaries land.

### Installed tools
`uv` is the only dev tool installed globally in the image (via the official installer, as `tb`).

Project-specific tools like `ruff` and `pyright` are not installed globally. Declare them as dev dependencies in the project's `pyproject.toml` and pin them in `uv.lock` — `uv` will download and cache them on first use:

```toml
[dependency-groups]
dev = ["ruff", "pyright"]
```

```bash
uv run ruff check .
uv run pyright
```

This ensures the same tool versions are used inside the container and on the host.

`~/.cache/uv` (wheel/package cache) and `~/.local/share/uv` (managed Python installations) are mounted from the host, so `uv` does not re-download Python or packages on each container start.
