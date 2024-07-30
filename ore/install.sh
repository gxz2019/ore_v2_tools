#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to check if Rust is installed
check_rust_installed() {
    if command -v rustc >/dev/null 2>&1; then
        echo "Rust is already installed."
        return 0
    else
        return 1
    fi
}

# Install Rust if not installed
if ! check_rust_installed; then
    echo "Installing Rust..."
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    # Add Rust to the PATH
    source $HOME/.cargo/env
fi

# Function to install packages
install_package() {
    local package=$1
    if command -v "$package" > /dev/null 2>&1; then
        echo "$package is already installed."
    else
        echo "$package not found. Installing..."
        if [ -f /etc/debian_version ]; then
            sudo apt-get update
            sudo apt-get install -y "$package"
        elif [ -f /etc/redhat-release ]; then
            sudo yum install -y "$package"
        else
            echo "Unsupported OS. Please install $package manually."
            exit 1
        fi
    fi
}

# Install curl and unzip if not already installed
install_package "curl"
install_package "unzip"

# Define variables
REPO_URL="https://github.com/regolith-labs/ore-cli"
RELEASE_URL="${REPO_URL}/archive/refs/heads/master.zip"
DOWNLOAD_DIR="../ore"
ZIP_FILE="ore-cli.zip"

# Download the latest release
echo "Downloading latest release from GitHub..."
curl -L -o "$DOWNLOAD_DIR/$ZIP_FILE" "$RELEASE_URL"

# Unzip the downloaded file
echo "Extracting release..."
unzip "$DOWNLOAD_DIR/$ZIP_FILE" -d "$DOWNLOAD_DIR"

# Move to the extracted directory
cd "$DOWNLOAD_DIR/ore-cli-master"

# Build ore-cli
echo "Building ore-cli..."
cargo build --release

# Clean up
echo "Cleaning up..."
rm "$DOWNLOAD_DIR/$ZIP_FILE"

echo "Installation and build complete!"
