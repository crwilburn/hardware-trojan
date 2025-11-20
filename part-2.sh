#!/bin/bash

# ==============================================================================
# PYENV SETUP PART 2: Python Version Installation and Venv Creation
# ==============================================================================

# --- Configuration Variables ---
PYTHON_VERSION="3.7.3"
VENV_NAME="venv"
SHELL_RC_FILE="$HOME/.bashrc"

# --- 0. Verification Check ---
echo "--- 0. Verifying pyenv load ---"

# Check if pyenv command is available
if ! command -v pyenv > /dev/null; then
    echo "ERROR: pyenv command is NOT found. Did the exec $SHELL command work?"
    echo "Please open a new window and try again, or re run ./part-1.sh"
    exit 1
fi
echo "pyenv command successfully loaded."

# --- 1. Install Python 3.7.3 ---
echo ""
echo "--- 1. Installing Python $PYTHON_VERSION via pyenv (This may take a while!) ---"

pyenv update
pyenv install "$PYTHON_VERSION"

if [ $? -ne 0 ]; then
    echo "ERROR: Failed to install Python $PYTHON_VERSION. Please check log for compilation errors. Exiting."
    exit 1
fi
echo "Python $PYTHON_VERSION installed successfully."

# --- 2. Set Version Locally and Verify ---
echo ""
echo "--- 2. Setting Python Version Locally ---"

# Set the Python version for this current directory.
pyenv local "$PYTHON_VERSION"
echo "Python $PYTHON_VERSION set as the local default."

# Verify the version for the script session
echo ""
echo "Current pyenv managed Python version:"
pyenv version

# --- 3. Create and Activate the virtual environment ---
echo ""
echo "--- 3. Creating Virtual Environment ('$VENV_NAME') ---"

# Use the pyenv-managed 'python3' to create the venv
python3 -m venv "$VENV_NAME"

if [ $? -ne 0 ]; then
    echo "ERROR: Failed to create virtual environment. Exiting."
    exit 1
fi
echo "Virtual environment '$VENV_NAME' created successfully."

# Activate the virtual environment internally for final check
source "$VENV_NAME/bin/activate"

# Verify the version *inside* the virtual environment
echo "Python version inside '$VENV_NAME':"
python --version

# Deactivate the environment before the script finishes
deactivate

# --- Final Instructions ---
echo ""
echo "==================================================================="
echo "✅ SETUP COMPLETE!"
echo "==================================================================="
echo ""
echo "Your environment is ready to use!"
echo ""
echo "To start your activity, run this command in your terminal:"
echo "   source $VENV_NAME/bin/activate"
