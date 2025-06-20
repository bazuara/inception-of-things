#!/bin/bash
set -e

echo "[INFO] Creating namespace 'argocd' if not exists"
kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -

echo "[INFO] Installing ArgoCD into 'argocd' namespace"
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "[INFO] Waiting for ArgoCD Server pod to be ready..."
kubectl wait --namespace argocd --for=condition=available --timeout=180s deployment/argocd-server

echo "[INFO] ArgoCD will be exposed through Ingress at https://argo.localhost"

ARGO_PASSWORD=$(kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

echo "[INFO] ArgoCD is installed and accessible at: http://localhost:30080"
echo "[INFO] Username: admin"
echo "[INFO] Password: $ARGO_PASSWORD"
