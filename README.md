# ex-gcp-k8s-prometheus
The place of my try and error

## Setup RBAC
```
kubectl create clusterrolebinding cluster-admin-binding --clusterrole cluster-admin --user <your account address>
kubectl get clusterrolebinding -o=json | jq '.items[] | select( .metadata.name | contains("cluster-admin-binding"))'
```
Ref. https://cloud.google.com/kubernetes-engine/docs/how-to/role-based-access-control

```
kubectl create -f clusterRole.yaml
```
Ref. https://github.com/prometheus/prometheus/blob/master/documentation/examples/rbac-setup.yml
Ref. https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account


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
