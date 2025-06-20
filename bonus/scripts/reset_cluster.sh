#!/bin/bash
set -e

echo "[INFO] Deleting ArgoCD namespace (if exists)..."
kubectl delete namespace argocd --ignore-not-found

echo "[INFO] Deleting ingress-nginx namespace (if exists)..."
kubectl delete namespace ingress-nginx --ignore-not-found

echo "[INFO] Deleting any Ingress resource for ArgoCD (if exists)..."
kubectl delete ingress argocd-ingress -n argocd --ignore-not-found

echo "[INFO] Deleting cluster 'iot-cluster' if exists..."
k3d cluster delete iot-cluster || true

kubectl delete ingress dev-ingress -n ingress-nginx --ignore-not-found

echo "[INFO] Cleanup complete."
