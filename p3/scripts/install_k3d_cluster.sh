#!/bin/bash
set -e

CURRENT_USER=$(whoami)

echo "[INFO] Running as user: $CURRENT_USER"

echo "[INFO] Checking if Docker is installed..."
if ! command -v docker &> /dev/null
then
  echo "[INFO] Docker not found. Installing Docker..."
  sudo apt update -y
  sudo apt install -y ca-certificates curl gnupg lsb-release

  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  sudo apt update -y
  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  echo "[INFO] Docker installed successfully."
fi

echo "[INFO] Checking if Docker daemon is accessible by user '$CURRENT_USER'..."
if ! docker info &> /dev/null
then
  echo "[INFO] Adding user '$CURRENT_USER' to the docker group..."
  sudo usermod -aG docker "$CURRENT_USER"
  echo "[INFO] User '$CURRENT_USER' added to docker group. Please logout or restart the VM for this to take effect."
  exit 0
fi
echo "[INFO] Docker is installed and accessible."

echo "[INFO] Installing k3d if not present"
if ! command -v k3d &> /dev/null
then
  curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
else
  echo "[INFO] k3d already installed"
fi

echo "[INFO] Checking if kubectl is installed..."
if ! command -v kubectl &> /dev/null
then
  echo "[INFO] Installing kubectl"
  curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  chmod +x kubectl
  sudo mv kubectl /usr/local/bin/
else
  echo "[INFO] kubectl already installed"
fi

echo "[INFO] Deleting existing cluster if it exists..."
k3d cluster delete iot-cluster || true

echo "[INFO] Creating k3d cluster named 'iot-cluster' with HTTP port mapped to localhost:30080"
k3d cluster create iot-cluster --api-port 6550 -p "30080:30080@loadbalancer" --wait

echo "[INFO] Setting KUBECONFIG environment variable"
export KUBECONFIG=$(k3d kubeconfig write iot-cluster)

echo "[INFO] Cluster 'iot-cluster' is ready and accessible via http://localhost:30080"
kubectl get nodes -o wide
