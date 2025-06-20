#!/bin/bash
set -e

CERT_DIR="./bonus/certs"
mkdir -p "$CERT_DIR"

echo "[INFO] Generating self-signed certificate for *.localhost..."

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout "$CERT_DIR/localhost.key" \
  -out "$CERT_DIR/localhost.crt" \
  -subj "/CN=localhost" \
  -addext "subjectAltName=DNS:localhost,DNS:argo.localhost,DNS:gitlab.localhost"

echo "[INFO] Creating Kubernetes TLS secret..."

kubectl create namespace ingress-nginx --dry-run=client -o yaml | kubectl apply -f -

kubectl delete secret tls-localhost --namespace ingress-nginx --ignore-not-found
kubectl create secret tls tls-localhost \
  --namespace ingress-nginx \
  --cert="$CERT_DIR/localhost.crt" \
  --key="$CERT_DIR/localhost.key"

echo "[INFO] TLS secret 'tls-localhost' created in namespace 'ingress-nginx'"
