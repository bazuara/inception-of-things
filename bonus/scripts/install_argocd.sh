#!/bin/bash
set -e

echo "[INFO] Creating namespace 'argocd' if not exists"
kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -

echo "[INFO] Installing ArgoCD into 'argocd' namespace"
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "[INFO] Patching ArgoCD Server service to NodePort on 8081..."
kubectl patch svc argocd-server -n argocd -p '{
  "spec": {
    "type": "NodePort",
    "ports": [{
      "port": 80,
      "targetPort": 8080,
      "nodePort": 30081,
      "protocol": "TCP"
    }]
  }
}'

echo "[INFO] Waiting for ArgoCD Server pod to be ready..."
kubectl wait --namespace argocd --for=condition=available --timeout=180s deployment/argocd-server

ARGO_PASSWORD=$(kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

echo "[INFO] ✅ ArgoCD is installed and accessible at: http://localhost:8081"
echo "[INFO] Username: admin"
echo "[INFO] Password: $ARGO_PASSWORD"
