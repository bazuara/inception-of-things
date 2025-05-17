#!/bin/bash
set -e

# Hardcoded Server IP and Token path
SERVER_IP="192.168.56.110"
TOKEN=$(cat /vagrant/token)

# Install K3s in agent mode pointing to the server
curl -sfL https://get.k3s.io | K3S_URL="https://$SERVER_IP:6443" K3S_TOKEN="$TOKEN" sh -

echo "[INFO] K3s Agent installation complete and joined to server $SERVER_IP"
