#!/bin/bash
set -e

echo "[INFO] Installing NGINX Ingress Controller"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.9.4/deploy/static/provider/baremetal/deploy.yaml

echo "[INFO] Waiting for ingress controller to be ready..."
kubectl rollout status deployment/ingress-nginx-controller -n ingress-nginx

echo "[INFO] Applying Namespace"
kubectl apply -f /vagrant/confs/app-namespace.yaml

echo "[INFO] Deploying HTML ConfigMap for App1"
kubectl apply -f /vagrant/confs/app1-configmap.yaml

echo "[INFO] Deploying App1 with custom HTML"
kubectl apply -f /vagrant/confs/app1-deployment.yaml


echo "[INFO] Deploying App2 with 3 replicas"
kubectl apply -f /vagrant/confs/app2-deployment.yaml

echo "[INFO] Deploying App3 (default)"
kubectl apply -f /vagrant/confs/app3-deployment.yaml

echo "[INFO] Deploying Ingress"
kubectl apply -f /vagrant/confs/app-ingress.yaml

echo "[INFO] Deployment Complete. Run 'kubectl get all -n apps' to verify."
echo "[INFO] Test access to App1 with: curl -H 'Host: app1.com' http://192.168.56.110"
echo "[INFO] Test access to App2 with: curl -H 'Host: app2.com' http://192.168.56.110"
echo "[INFO] Test access to App3 with: curl http://192.168.56.110"