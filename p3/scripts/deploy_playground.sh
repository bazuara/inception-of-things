#!/bin/bash
set -e

# Resolve the absolute path to the script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo "[INFO] Using project root: $PROJECT_ROOT"

echo "[INFO] Deploying 'dev' namespace..."
kubectl apply -f "$PROJECT_ROOT/confs/dev-namespace.yaml"

echo "[INFO] Registering application in ArgoCD..."
kubectl apply -f "$PROJECT_ROOT/confs/argocd-app.yaml"

echo "[INFO] Deployment registered in ArgoCD. You can now manage it through the ArgoCD web UI at http://localhost:30080"

