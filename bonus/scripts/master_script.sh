#!/bin/bash
set -e

echo
echo "🌀 [INFO] Starting BONUS deployment for K3d + GitLab + ArgoCD + TLS"
read -p "❓ Reset cluster first? (y/N): " choice

if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
  ./bonus/scripts/reset_cluster.sh
else
  echo "[INFO] Keeping current cluster..."
fi

./bonus/scripts/install_k3d_cluster.sh
./bonus/scripts/deploy_gitlab.sh
./bonus/scripts/install_argocd.sh
./bonus/scripts/deploy_playground.sh

echo "[INFO] Waiting for GitLab to become fully available..."

until curl -s -o /dev/null -w "%{http_code}" http://localhost:8082/users/sign_in | grep -q "200"; do
  echo "[WAIT] GitLab is still booting... retrying in 10 seconds."
  sleep 10
done

echo "[✅] GitLab is now fully operational at http://localhost:8082"

echo "[INFO] Waiting for GitLab to generate initial root password..."

until kubectl -n gitlab exec deploy/gitlab -- test -f /etc/gitlab/initial_root_password; do
  echo "[WAIT] File not found yet... retrying in 10 seconds."
  sleep 10
done

echo "[✅] File found. Extracting password..."
GITLAB_PASSWORD=$(kubectl -n gitlab exec deploy/gitlab -- grep 'Password:' /etc/gitlab/initial_root_password | awk '{print $2}')

echo
echo "[✅] All components deployed."
echo "  - ArgoCD: http://localhost:8081"
echo "  - User: admin"
echo "  - Password: $(kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d && echo)"
echo "  - GitLab: http://localhost:8082"
echo "  - user: root"
echo "  - password: $GITLAB_PASSWORD"
