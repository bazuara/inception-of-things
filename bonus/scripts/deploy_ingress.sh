#!/bin/bash
set -e

echo "[INFO] Deploying unified ingress for ArgoCD and GitLab..."
kubectl apply -f bonus/confs/gitlab-ingress.yaml

echo "[INFO] Ingress successfully deployed. Access:"
echo "  - ArgoCD: https://argo.localhost"
echo "  - GitLab: https://gitlab.localhost"
