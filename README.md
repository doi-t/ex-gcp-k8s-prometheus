# ex-gcp-k8s-prometheus
The place of my try and error

## Access Promethus Dashboard
```
PROM_SERVER_POD_NAME=$(kubectl get pods --namespace monitoring -l "name=prometheus" -o jsonpath="{.items[0].metadata.name}")
kubectl port-forward ${PROM_SERVER_POD_NAME} 9090:9090 --namespace monitoring
```

## Check Rsources
```
kubectl get pods,deployments,services,configmaps,namespaces,serviceaccount --show-labels --namespace monitoring
```

## Check Prometheus Server Logs
```
brew install stern
stern prometheus --namespace monitoring
```

## Check CPU/Memory Requests and Limits
```
kubectl describe nodes
```

## Check Actual Resource Usage
```
kubectl top pod --namespace monitoring
```
