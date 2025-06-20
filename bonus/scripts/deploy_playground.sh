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
echo "---------------------------------------------"
echo "[INFO] Playground application deployed successfully."
echo "[INFO] You can verify the running version (expected v1) with the following commands:"
echo
echo "  # Get the ClusterIP and Port of the playground service"
echo "  kubectl get svc -n dev"
echo
echo "  # Start a temporary busybox pod to test connectivity"
echo "  kubectl run -i --tty --rm debug --image=busybox --restart=Never -- sh"
echo
echo "  # Inside the pod, run (replace <ClusterIP> with the actual IP):"
echo "  wget -qO- http://<ClusterIP>:8888"
echo
echo "[INFO] Expected output: {\"status\":\"ok\", \"message\": \"v1\"}"
echo "---------------------------------------------"
echo "[INFO] When updating the application to version v2"
echo
echo "[ACTION] Edit your GitHub repository to update the image tag:"
echo
echo "  - Open: https://github.com/bazuara/inception-of-things"
echo "  - Go to: p3/confs/app-deployment.yaml"
echo "  - Change:"
echo "      image: wil42/playground:v1"
echo "    to:"
echo "      image: wil42/playground:v2"
echo "  - Commit and push the changes."
echo
echo "[INFO] After pushing, go to ArgoCD (http://localhost:30080) and:"
echo "  - Look for the application 'playground-app'."
echo "  - It should appear as 'OutOfSync'."
echo "  - Click 'Sync' to apply the update if it doesn't sync automatically."
echo
echo "---------------------------------------------"
echo "[INFO] Verifying that the new version (v2) is running."
echo "[INFO] You can re-run the following to check the new version:"
echo
echo "  # Start a temporary busybox pod again if needed"
echo "  kubectl run -i --tty --rm debug --image=busybox --restart=Never -- sh"
echo
echo "  # Inside the pod, run again (replace <ClusterIP> with the actual IP):"
echo "  wget -qO- http://<ClusterIP>:8888"
echo
echo "[INFO] Expected output: {\"status\":\"ok\", \"message\": \"v2\"}"
echo "---------------------------------------------"
