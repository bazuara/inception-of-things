#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo "[INFO] Using project root: $PROJECT_ROOT"

echo "[INFO] Deploying 'dev' namespace..."
kubectl apply -f "$PROJECT_ROOT/confs/dev-namespace.yaml"

echo
echo "⚠️  Before continuing:"
echo "   👉 Ensure your GitLab repository exists and is ready to receive content."
echo "   👉 You can push your current repo to GitLab with:"
echo
echo "      git remote add gitlab http://localhost:8082/root/inception-of-things.git"
echo "      git push gitlab master"
echo
read -p "❓ Have you created the GitLab repo and pushed the manifests? (y/N): " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo "[✋] Aborted by user. Please create the repo and push the files before retrying."
  exit 1
fi

echo "[INFO] Registering application in ArgoCD..."
kubectl apply -f "$PROJECT_ROOT/confs/argocd-app.yaml"

echo "---------------------------------------------"
echo "[✅] Playground application registered in ArgoCD."
echo "[ℹ️] Manage it at: http://localhost:8081"
echo "---------------------------------------------"
