#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo "[INFO] Using project root: $PROJECT_ROOT"

echo "[INFO] Deploying 'dev' namespace..."
kubectl apply -f "$PROJECT_ROOT/confs/dev-namespace.yaml"

echo "[INFO] Registering application in ArgoCD..."
kubectl apply -f "$PROJECT_ROOT/confs/argocd-app.yaml"

echo "---------------------------------------------"
echo "[✅] Playground application registered in ArgoCD."
echo "[ℹ️] Manage it at: http://localhost:8081"
echo "---------------------------------------------"
