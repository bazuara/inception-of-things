#!/bin/bash
set -e

ROLE=$1

if [[ "$ROLE" == "server" ]]; then
  curl -sfL https://get.k3s.io | sh -
  mkdir -p /home/vagrant/.kube
  cp /etc/rancher/k3s/k3s.yaml /home/vagrant/.kube/config
  chown -R vagrant:vagrant /home/vagrant/.kube
elif [[ "$ROLE" == "agent" ]]; then
  # Wait for server node to be ready and get the token
  until ping -c1 192.168.56.110 &>/dev/null; do sleep 1; done
  TOKEN=$(ssh -o StrictHostKeyChecking=no -i /vagrant/.vagrant/machines/yourloginS/virtualbox/private_key vagrant@192.168.56.110 "sudo cat /var/lib/rancher/k3s/server/node-token")
  curl -sfL https://get.k3s.io | K3S_URL="https://192.168.56.110:6443" K3S_TOKEN="$TOKEN" sh -
else
  echo "Usage: $0 [server|agent]"
  exit 1
fi
