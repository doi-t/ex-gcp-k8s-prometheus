#!/bin/bash
set -e

SERVICE_NAME='alertmanager'
PORT=9093
NAMESPACE=${ENVIRONMENT}-monitoring
POD_NAME=$(kubectl get pods --namespace ${NAMESPACE} -l "name=${SERVICE_NAME},variant=${ENVIRONMENT}" -o jsonpath="{.items[0].metadata.name}")

echo "Pod name: ${POD_NAME}"
kubectl port-forward ${POD_NAME} ${PORT}:${PORT} --namespace ${NAMESPACE}
