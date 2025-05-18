#!/bin/bash
set -e

echo
echo "⚠️  WARNING: You are about to deploy or reset your K3d cluster."
read -p "❓ Do you want to destroy the existing cluster first? (y/N): " choice

if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
  echo "[INFO] Destroying existing cluster..."
  ./scripts/reset_cluster.sh
else
  echo "[INFO] Keeping existing cluster..."
fi

echo
echo "[INFO] Starting full deployment sequence..."
./scripts/install_k3d_cluster.sh && \
./scripts/install_argocd.sh && \
./scripts/fix_dns.sh && \
./scripts/deploy_playground.sh

echo
echo "[INFO] ✅ Full deployment completed successfully. Access ArgoCD at http://localhost:30080"
