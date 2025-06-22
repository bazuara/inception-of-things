#!/bin/bash
set -e

echo "[INFO] Patching CoreDNS to forward to 8.8.8.8 for external DNS resolution..."

# Patch CoreDNS ConfigMap
kubectl patch configmap coredns -n kube-system --type merge -p '{"data":{"Corefile":".:53 {\n    errors\n    health\n    ready\n    kubernetes cluster.local in-addr.arpa ip6.arpa {\n       pods insecure\n       fallthrough in-addr.arpa ip6.arpa\n    }\n    prometheus :9153\n    forward . 8.8.8.8\n    cache 30\n    loop\n    reload\n    loadbalance\n}\n"}}'

echo "[INFO] Restarting CoreDNS to apply changes..."
kubectl -n kube-system rollout restart deployment coredns

echo "[INFO] DNS patch applied and CoreDNS restarted successfully."
