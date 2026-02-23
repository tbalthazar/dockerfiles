# Claude Code Docker Setup

Run Claude Code in an isolated Docker container while using Neovim on your local machine.

## Files

- `Dockerfile` - Defines the Claude Code container image using native installation with a non-root user
- `run-claude.sh` - Script to run Claude Code with mounted project and credentials

## How It Works

The Dockerfile creates a non-root user (`user`) and installs Claude Code as that user. This ensures:
- Claude Code installs to `/home/user/.local/bin/` (the standard location)
- Your credentials mount to `/home/user/.claude/` (matching the user's home)
- The container always runs as the `user` account (more secure)

## Setup

### 1. Build the Docker Image (Optional - script does this automatically)

```bash
docker build -t claude-code-dev .
```

The build process:
1. Creates a `user` account with home directory
2. Switches to that user
3. Runs the official install script (installs to `/home/user/.local/bin/claude`)
4. Verifies the binary was created successfully

### 2. Make Script Executable

```bash
chmod +x run-claude.sh
```

### 3. Authenticate Claude (First Time Only)

On first run, you'll need to authenticate Claude Code:

```bash
./run-claude.sh /path/to/your/project

# Inside the container:
claude

# Follow the authentication prompts
# Your credentials will be saved to ~/.claude/.credentials.json on your host
```

## Usage

### Start Claude Code

```bash
./run-claude.sh /path/to/your/project
```

This will:
- Build the Docker image if it doesn't exist
- Start a fresh container with `--rm` (auto-cleanup on exit)
- Mount your project directory to `/workspace` in the container
- Mount your `~/.claude` config directory so credentials persist
- Start a bash shell in the container

### Inside the Container

```bash
# Start Claude Code
claude

# Your project files are in /workspace
cd /workspace
ls

# Tell Claude what to do
# Example: "Create a Python function to calculate fibonacci numbers"
```

### On Your Laptop (Separate Terminal)

```bash
# Edit files with Neovim
cd /path/to/your/project
nvim src/main.py

# Changes made by Claude appear immediately
# Changes you make are visible to Claude
```

## Workflow

1. **Terminal 1 (Docker)**: Run `./run-claude.sh /path/to/project` and then `claude`
2. **Terminal 2 (Laptop)**: Edit with `nvim` in your project directory
3. Claude modifies files in the container
4. Changes sync instantly via the mounted volume
5. You see Claude's changes in Neovim (enable auto-reload)

## Security Features

- **Isolated Environment**: Claude only sees the mounted project directory
- **No Host Access**: Your other files, credentials, and projects are invisible
- **Persistent Credentials**: Login once, credentials stored in `~/.claude/`
- **Easy Cleanup**: Remove container anytime with `docker rm claude-<project-name>`

## Container Management

The container uses `--rm` flag, so it automatically cleans up when you exit. No manual cleanup needed!

### Switch Projects

Just run the script with a different path:
```bash
./run-claude.sh ~/project-a  # Work on project A
# Exit when done (container auto-removed)

./run-claude.sh ~/project-b  # Work on project B  
# Fresh container, different project mounted
```

### Force Rebuild Image
```bash
docker rmi claude-code-dev
./run-claude.sh /path/to/project  # Will rebuild automatically
```

## Neovim Auto-Reload

Add this to your `init.lua` or `init.vim` to auto-reload when Claude changes files:

**Lua (init.lua):**
```lua
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  pattern = "*",
  command = "checktime",
})
```

**Vimscript (init.vim):**
```vim
set autoread
autocmd FocusGained,BufEnter,CursorHold * checktime
```

## Troubleshooting

### "Image not found" error
The script will automatically build the image. Ensure `Dockerfile` is in the same directory.

### Authentication issues
If Claude keeps asking to login, check that `~/.claude/.credentials.json` exists on your host.

### File permission issues
The container runs as the `user` account (not root). Files created by Claude will be owned by the container's `user` UID.

To fix ownership on your host:
```bash
sudo chown -R $USER:$USER /path/to/your/project
```

To run commands as root inside the container (if needed):
```bash
docker exec -u root -it claude-dev bash
```

### Want to keep a container running?
By default, containers auto-remove on exit (clean and simple). If you want a persistent container, remove the `--rm` flag from the script.

## Advanced: Working with Multiple Projects

Switching between projects is simple since each run gets a fresh container with the correct mounts:

```bash
# Work on project A
./run-claude.sh ~/project-a
# ... do work, exit when done (container auto-removed)

# Work on project B
./run-claude.sh ~/project-b
# ... fresh container with project-b mounted
```

All projects share the same credentials from `~/.claude/`, so you only authenticate once.
