#!/bin/bash

# Variables
KUBE_CLIENT_GO_EXEC_PLUGINS_VERSION="v0.0.2"
INSTALL_DIR="/usr/local/bin"

# Plugin URLs
GCP_PLUGIN_URL="https://github.com/plantoncloud/kube-client-go-exec-plugins/releases/download/$KUBE_CLIENT_GO_EXEC_PLUGINS_VERSION/kube-client-go-gcp-credential-exec-plugin-linux"
AWS_PLUGIN_URL="https://github.com/plantoncloud/kube-client-go-exec-plugins/releases/download/$KUBE_CLIENT_GO_EXEC_PLUGINS_VERSION/kube-client-go-aws-credential-exec-plugin-linux"
AZURE_PLUGIN_URL="https://github.com/plantoncloud/kube-client-go-exec-plugins/releases/download/$KUBE_CLIENT_GO_EXEC_PLUGINS_VERSION/kube-client-go-azure-credential-exec-plugin-linux"

# Plugin names
GCP_PLUGIN_NAME="kube-client-go-gcp-exec-plugin"
AWS_PLUGIN_NAME="kube-client-go-aws-exec-plugin"
AZURE_PLUGIN_NAME="kube-client-go-azure-exec-plugin"

# Check if /usr/local/bin is writable
if [ ! -w "$INSTALL_DIR" ]; then
  echo "Error: You do not have write permissions for $INSTALL_DIR. Try running the script with sudo."
  exit 1
fi

# Download, install, and verify each plugin

# GCP Plugin
echo "Downloading $GCP_PLUGIN_NAME from $GCP_PLUGIN_URL..."
curl -L "$GCP_PLUGIN_URL" -o "$GCP_PLUGIN_NAME"
chmod +x "$GCP_PLUGIN_NAME"
mv "$GCP_PLUGIN_NAME" "$INSTALL_DIR/$GCP_PLUGIN_NAME"
if [ -f "$INSTALL_DIR/$GCP_PLUGIN_NAME" ]; then
  echo "$GCP_PLUGIN_NAME installed successfully to $INSTALL_DIR."
else
  echo "Error: Installation of $GCP_PLUGIN_NAME failed."
  exit 1
fi

# AWS Plugin
echo "Downloading $AWS_PLUGIN_NAME from $AWS_PLUGIN_URL..."
curl -L "$AWS_PLUGIN_URL" -o "$AWS_PLUGIN_NAME"
chmod +x "$AWS_PLUGIN_NAME"
mv "$AWS_PLUGIN_NAME" "$INSTALL_DIR/$AWS_PLUGIN_NAME"
if [ -f "$INSTALL_DIR/$AWS_PLUGIN_NAME" ]; then
  echo "$AWS_PLUGIN_NAME installed successfully to $INSTALL_DIR."
else
  echo "Error: Installation of $AWS_PLUGIN_NAME failed."
  exit 1
fi

# Azure Plugin
echo "Downloading $AZURE_PLUGIN_NAME from $AZURE_PLUGIN_URL..."
curl -L "$AZURE_PLUGIN_URL" -o "$AZURE_PLUGIN_NAME"
chmod +x "$AZURE_PLUGIN_NAME"
mv "$AZURE_PLUGIN_NAME" "$INSTALL_DIR/$AZURE_PLUGIN_NAME"
if [ -f "$INSTALL_DIR/$AZURE_PLUGIN_NAME" ]; then
  echo "$AZURE_PLUGIN_NAME installed successfully to $INSTALL_DIR."
else
  echo "Error: Installation of $AZURE_PLUGIN_NAME failed."
  exit 1
fi

echo "All plugins installed successfully!"
