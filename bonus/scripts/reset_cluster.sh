#!/bin/bash
set -e

echo "[INFO] Deleting cluster 'iot-cluster' if exists..."
k3d cluster delete iot-cluster || true

echo "[INFO] Cleanup complete."

