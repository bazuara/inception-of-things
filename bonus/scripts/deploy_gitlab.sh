#!/bin/bash
set -e

echo "[INFO] Creating 'gitlab' namespace..."
kubectl create namespace gitlab --dry-run=client -o yaml | kubectl apply -f -

echo "[INFO] Deploying GitLab (this may take several minutes)..."
kubectl apply -f bonus/confs/gitlab-deployment.yaml

echo "[INFO] Waiting for GitLab pod to be ready..."
kubectl rollout status deployment/gitlab -n gitlab --timeout=300s

echo "[INFO] GitLab deployment is ready."
