#!/usr/bin/env bash
#
# AI BU Prompt Library Installer
# Clones the prompt library and verifies the setup.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/MarkellR-RedHat/ai-bu-prompt-library/main/install.sh | bash
#
# Or run directly:
#   ./install.sh [target-directory]
#

set -euo pipefail

REPO_URL="https://github.com/MarkellR-RedHat/ai-bu-prompt-library.git"
DEFAULT_DIR="ai-bu-prompt-library"
INSTALL_DIR="${1:-$DEFAULT_DIR}"

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

info()  { printf "\033[1;34m==>\033[0m %s\n" "$1"; }
ok()    { printf "\033[1;32m  +\033[0m %s\n" "$1"; }
warn()  { printf "\033[1;33m  !\033[0m %s\n" "$1"; }
fail()  { printf "\033[1;31mERROR:\033[0m %s\n" "$1" >&2; exit 1; }

# ---------------------------------------------------------------------------
# Preflight checks
# ---------------------------------------------------------------------------

info "Checking prerequisites..."

if ! command -v git &>/dev/null; then
    fail "git is not installed. Install git and try again."
fi
ok "git found: $(git --version)"

# ---------------------------------------------------------------------------
# Clone or update
# ---------------------------------------------------------------------------

if [ -d "$INSTALL_DIR/.git" ]; then
    info "Directory '$INSTALL_DIR' already exists. Pulling latest changes..."
    git -C "$INSTALL_DIR" pull --ff-only || fail "Could not pull latest changes. Resolve conflicts and try again."
    ok "Updated to latest"
else
    if [ -e "$INSTALL_DIR" ]; then
        fail "'$INSTALL_DIR' already exists but is not a git repo. Remove it or choose a different directory: ./install.sh my-prompts"
    fi
    info "Cloning prompt library into '$INSTALL_DIR'..."
    git clone "$REPO_URL" "$INSTALL_DIR" || fail "Clone failed. Check your network connection and repo access."
    ok "Cloned successfully"
fi

# ---------------------------------------------------------------------------
# Verify contents
# ---------------------------------------------------------------------------

info "Verifying installation..."

prompt_count=$(find "$INSTALL_DIR" -name "*.md" -not -name "README.md" -not -path "*/.git/*" | wc -l | tr -d ' ')
category_count=$(find "$INSTALL_DIR" -mindepth 1 -maxdepth 1 -type d -not -name ".git" -not -name ".*" | wc -l | tr -d ' ')

ok "$prompt_count prompts across $category_count categories"

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------

printf "\n"
info "Installation complete!"
printf "\n"
printf "  Prompt library: %s\n" "$(cd "$INSTALL_DIR" && pwd)"
printf "\n"
printf "  Get started:\n"
printf "    1. Browse prompts:  ls %s/\n" "$INSTALL_DIR"
printf "    2. Try a prompt:    cat %s/content/blog-intro.md\n" "$INSTALL_DIR"
printf "    3. Learn the craft: cat %s/meta/prompt-engineering-guide.md\n" "$INSTALL_DIR"
printf "\n"
printf "  Fill in the [BRACKETED] placeholders and paste into your LLM.\n"
printf "\n"
