#!/bin/bash
set -e

# Install K3s in server mode with TLS SAN to avoid cert issues on external IPs
curl -sfL https://get.k3s.io | sh -s - --tls-san 192.168.56.110

# Prepare kube config for vagrant user
mkdir -p /home/vagrant/.kube
cp /etc/rancher/k3s/k3s.yaml /home/vagrant/.kube/config
chown -R vagrant:vagrant /home/vagrant/.kube

# Make KUBECONFIG persistent for vagrant user
echo 'export KUBECONFIG=/home/vagrant/.kube/config' >> /home/vagrant/.bashrc

# Export token to shared folder for agent to read later
sudo cat /var/lib/rancher/k3s/server/node-token > /vagrant/token

echo "[INFO] K3s Server installation complete and token saved to /vagrant/token"
