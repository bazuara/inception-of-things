#!/bin/bash
set -e

echo "[INFO] Deleting ArgoCD namespace (if exists)..."
kubectl delete namespace argocd --ignore-not-found

echo "[INFO] Deleting GitLab namespace (if exists)..."
kubectl delete namespace gitlab --ignore-not-found

echo "[INFO] Deleting ingress-nginx namespace (if exists)..."
kubectl delete namespace ingress-nginx --ignore-not-found

echo "[INFO] Deleting TLS secret (if exists)..."
kubectl delete secret tls-localhost -n ingress-nginx --ignore-not-found

echo "[INFO] Deleting cluster 'iot-cluster' if exists..."
k3d cluster delete iot-cluster || true

echo "[INFO] Cleanup complete."

