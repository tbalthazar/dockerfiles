# Claude Code Docker Setup

Run Claude Code in an isolated Docker container.

## Files

- `Dockerfile` - Defines the Claude Code container image using native installation with a non-root user (`tb`)
- `build-and-push.sh` - Script to build the image and push it to Docker Hub (maintainers only)

## How It Works

The Dockerfile creates a non-root user (`tb`) and installs Claude Code as that user. The pre-built image is available on Docker Hub as `tbalthazar/claude-code-dev`.

A separate `claude-docker` launch script (in a separate repository) pulls and runs the image. It mounts:
- The current directory into `/workspace`
- `~/.claude/` for persistent credentials and config
- `~/.claude.json` for top-level Claude config (OAuth, theme, etc.)
- `~/.gitconfig` for git identity and aliases
- `~/.cache/uv` so downloaded wheels and package metadata persist across container runs
- `~/.local/share/uv` so `uv`-managed Python installations persist across container runs

`uv` is the only dev tool installed globally. Project-specific tools (`ruff`, `pyright`, etc.) should be declared in the project's `pyproject.toml` and pinned in `uv.lock` — `uv` will download and cache them on first use via `uv run`.

## For Maintainers: Building and Publishing the Image

```bash
docker login
chmod +x build-and-push.sh
./build-and-push.sh
```

This builds the image from the local `Dockerfile` and pushes it to `tbalthazar/claude-code-dev` on Docker Hub.
