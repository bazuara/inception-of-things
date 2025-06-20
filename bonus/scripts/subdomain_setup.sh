#!/bin/bash
set -e

HOSTS_FILE="/etc/hosts"
SUBDOMAINS=("gitlab.localhost" "argo.localhost")
LINE_TO_ADD="127.0.0.1 argo.localhost gitlab.localhost"

echo "[INFO] Checking if /etc/hosts contains gitlab.localhost and argo.localhost..."

MISSING=false
for domain in "${SUBDOMAINS[@]}"; do
  if ! grep -q "$domain" "$HOSTS_FILE"; then
    MISSING=true
  fi
done

if [ "$MISSING" = true ]; then
  echo "[INFO] Some subdomains are missing. Adding to /etc/hosts..."
  echo "$LINE_TO_ADD" | sudo tee -a "$HOSTS_FILE" > /dev/null
  echo "[✅] Subdomains added to /etc/hosts:"
  echo "     $LINE_TO_ADD"
else
  echo "[INFO] Subdomains already present in /etc/hosts. No action taken."
fi
