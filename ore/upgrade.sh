#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
REPO_URL="https://github.com/regolith-labs/ore-cli"
CLONE_DIR="../ore"

# Remove old directory if it exists
if [ -d "$CLONE_DIR/ore-cli-master" ]; then
    echo "Removing old directory..."
    rm -rf "$CLONE_DIR/ore-cli-master"
fi

# Clone the latest release
echo "Cloning latest release from GitHub..."
git clone "$REPO_URL" "$CLONE_DIR"

# Move to the cloned directory
cd "$CLONE_DIR/ore-cli-master"

# Build ore-cli
echo "Building ore-cli..."
cargo build --release

echo "Upgrade complete!"
