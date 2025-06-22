#!/bin/bash
set -e

echo
echo "🌀 [INFO] Starting BONUS deployment for K3d + GitLab + ArgoCD + TLS"
read -p "❓ Reset cluster first? (y/N): " choice

if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
  ./p3/scripts/reset_cluster.sh
else
  echo "[INFO] Keeping current cluster..."
fi

./bonus/scripts/install_k3d_cluster.sh
./bonus/scripts/install_argocd.sh
./bonus/scripts/deploy_gitlab.sh
./bonus/scripts/deploy_playground.sh

echo
echo "[✅] All components deployed."
echo "  - ArgoCD: http://localhost:8081"
echo "  - GitLab: http://localhost:8082"
