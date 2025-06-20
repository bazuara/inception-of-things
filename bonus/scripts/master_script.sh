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

./p3/scripts/install_k3d_cluster.sh
./p3/scripts/install_argocd.sh
./bonus/scripts/gen_cert.sh
./bonus/scripts/deploy_gitlab.sh
./p3/scripts/fix_dns.sh
./p3/scripts/deploy_playground.sh
./bonus/scripts/deploy_ingress.sh

echo
echo "[✅] All components deployed."
echo "  - ArgoCD: https://argo.localhost"
echo "  - GitLab: https://gitlab.localhost"
