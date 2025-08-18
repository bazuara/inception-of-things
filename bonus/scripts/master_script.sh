#!/bin/bash
set -e

echo
echo "🌀 [INFO] Starting BONUS deployment for K3d + GitLab + ArgoCD + TLS"
read -p "❓ Reset cluster first? (y/N): " choice

if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
  ./scripts/reset_cluster.sh
else
  echo "[INFO] Keeping current cluster..."
fi

./scripts/install_k3d_cluster.sh
./scripts/install_argocd.sh
./scripts/deploy_gitlab.sh
./scripts/deploy_playground.sh

echo
echo "[✅] All components deployed."
echo "  - ArgoCD: http://localhost:8081"
echo "  - User: admin"
echo "  - Password: $(kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d && echo)"
echo "  - GitLab: http://localhost:8082"
echo "  - User: root"
echo "  - $(kubectl -n gitlab exec -it deploy/gitlab -- grep 'Password:' /etc/gitlab/initial_root_password)"
