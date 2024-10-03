#!/bin/bash

# Variables
KUBE_CLIENT_GO_EXEC_PLUGINS_VERSION="v0.0.2"
INSTALL_DIR="/usr/local/bin"

# Determine OS
OS=$(uname -s | tr '[:upper:]' '[:lower:]')

# Determine architecture
ARCH=$(uname -m)
case $ARCH in
    x86_64)
        ARCH="amd64"
        ;;
    arm64|aarch64)
        ARCH="arm64"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

# Plugin URLs based on OS and architecture
GCP_PLUGIN_URL="https://github.com/plantoncloud/kube-client-go-exec-plugins/releases/download/$KUBE_CLIENT_GO_EXEC_PLUGINS_VERSION/kube-client-go-gcp-credential-exec-plugin-${OS}-${ARCH}"
AWS_PLUGIN_URL="https://github.com/plantoncloud/kube-client-go-exec-plugins/releases/download/$KUBE_CLIENT_GO_EXEC_PLUGINS_VERSION/kube-client-go-aws-credential-exec-plugin-${OS}-${ARCH}"
AZURE_PLUGIN_URL="https://github.com/plantoncloud/kube-client-go-exec-plugins/releases/download/$KUBE_CLIENT_GO_EXEC_PLUGINS_VERSION/kube-client-go-azure-credential-exec-plugin-${OS}-${ARCH}"

# Plugin names
GCP_PLUGIN_NAME="kube-client-go-gcp-exec-plugin"
AWS_PLUGIN_NAME="kube-client-go-aws-exec-plugin"
AZURE_PLUGIN_NAME="kube-client-go-azure-exec-plugin"

# Check if /usr/local/bin is writable
if [ ! -w "$INSTALL_DIR" ]; then
  echo "Error: You do not have write permissions for $INSTALL_DIR. Try running the script with sudo."
  exit 1
fi

# Function to download and install a plugin
install_plugin() {
  local url=$1
  local name=$2

  echo "Downloading $name from $url..."
  curl -L "$url" -o "$name"
  chmod +x "$name"
  mv "$name" "$INSTALL_DIR/$name"

  # Verify installation
  if [ -f "$INSTALL_DIR/$name" ]; then
    echo "$name installed successfully to $INSTALL_DIR."
  else
    echo "Error: Installation of $name failed."
    exit 1
  fi
}

# Install GCP Plugin
install_plugin "$GCP_PLUGIN_URL" "$GCP_PLUGIN_NAME"

# Install AWS Plugin
install_plugin "$AWS_PLUGIN_URL" "$AWS_PLUGIN_NAME"

# Install Azure Plugin
install_plugin "$AZURE_PLUGIN_URL" "$AZURE_PLUGIN_NAME"

echo "All plugins installed successfully!"
