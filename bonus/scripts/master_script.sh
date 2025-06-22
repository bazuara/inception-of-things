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

echo "------------------------------------------------------------"
echo "[🧪 VERIFICACIÓN MANUAL DEL PLAYGROUND]"
echo
echo "1. Ejecuta este comando para obtener la IP del servicio:"
echo "   kubectl get svc -n dev"
echo
echo "2. Copia la ClusterIP del servicio llamado 'playground'."
echo
echo "3. Lanza un pod temporal para probar la app desde dentro del cluster:"
echo "   kubectl run -i --tty debug --image=busybox --rm --restart=Never -- sh"
echo
echo "4. Dentro del pod, ejecuta:"
echo "   wget -qO- http://<ClusterIP>:8888"
echo
echo "✅ Si todo va bien, verás:"
echo "   {\"status\":\"ok\", \"message\": \"v1\"}  (o v2 si ya hiciste upgrade)"
echo "------------------------------------------------------------"
