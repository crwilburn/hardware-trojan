#!/bin/bash

# ==============================================================================
# PYENV SETUP PART 1: Prerequisites, Pyenv Installation, and Configuration
# ==============================================================================

# --- Configuration Variables ---
SHELL_RC_FILE="$HOME/.bashrc"
PYENV_ROOT="$HOME/.pyenv"

# --- 0. Install ALL Necessary Dependencies ---
echo "--- 0. Installing ALL System Dependencies (Build Tools, Python Libraries) ---"
sudo apt-get update
sudo apt-get install -y \
  curl git build-essential \
  libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm \
  libncurses5-dev libncursesw5-dev xz-utils tk-dev libgdbm-dev lzma lzma-dev \
  tcl-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev wget openssl

if [ $? -ne 0 ]; then
    echo "ERROR: Failed to install required system dependencies."
fi
echo "All dependencies installed successfully."

# --- 1. Installing pyenv ---
echo ""
echo "--- 1. Installing pyenv ---"

# Remove existing pyenv installation directory to prevent "cannot proceed" error
if [ -d "$PYENV_ROOT" ]; then
    echo "WARNING: Found existing $PYENV_ROOT directory. Removing it now to ensure a clean installation."
    rm -rf "$PYENV_ROOT"
fi

# Install Pyenv
curl -L https://pyenv.run | bash

if [ $? -ne 0 ]; then
    echo "ERROR: pyenv installation failed. Exiting."
    exit 1
fi
echo "Pyenv installed successfully to $PYENV_ROOT."

# --- 2. Configure .bashrc for permanent pyenv use ---
echo ""
echo "--- 2. Configuring $SHELL_RC_FILE ---"

# Define the lines individually for maximum shell compatibility
LINE1='export PATH="$HOME/.pyenv/bin:$PATH"'
LINE2='eval "$(pyenv init --path)"'
LINE3='eval "$(pyenv virtualenv-init -)"'

# Function to check if a line exists and add it if missing
add_line_if_missing() {
    local line_to_add="$1"
    if ! grep -qF "$line_to_add" "$SHELL_RC_FILE"; then
        echo "$line_to_add" >> "$SHELL_RC_FILE"
        echo "   - Added: $line_to_add"
    else
        echo "   - Already present: $line_to_add (Skipping)"
    fi
}

# Use printf for robust newline insertion and comments
printf "\n# --- pyenv setup start (Added by setup script) ---\n" >> "$SHELL_RC_FILE"

add_line_if_missing "$LINE1"
add_line_if_missing "$LINE2"
add_line_if_missing "$LINE3"

echo "# --- pyenv setup end ---" >> "$SHELL_RC_FILE"
echo "Configuration lines added successfully to $SHELL_RC_FILE."

# --- Final Instructions for User ---
echo ""
echo "==================================================================="
echo "✅ PART 1 COMPLETE!"
echo "==================================================================="
echo ""
echo "NEXT CRITICAL STEP:"
echo "Run the command 'exec $SHELL'"
echo "2. Run the second setup script:"
echo ""
echo "    ./part-2.sh"
echo ""
