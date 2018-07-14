# ex-gcp-k8s-prometheus
[Promethus](https://github.com/prometheus/prometheus) server on k8s/GKE for multiple environments managed by [kustomize](https://github.com/kubernetes-sigs/kustomize).

## Setup RBAC
```
kubectl create clusterrolebinding cluster-admin-binding --clusterrole cluster-admin --user <your account address>
kubectl get clusterrolebinding -o=json | jq '.items[] | select( .metadata.name | contains("cluster-admin-binding"))'
```
Ref. https://cloud.google.com/kubernetes-engine/docs/how-to/role-based-access-control
TODO: make it yaml configuration if it is possible.

## Deploy Promethus Server to GKE
### Deploy Development Environment
```
ikustomize build overlays/dev | kubectl apply -f -
```
### Deploy Staging Environment
```
ikustomize build overlays/stg | kubectl apply -f -
```

## Debugging and Understanding What is Happening on k8s/GKE
The following commands sometimes expect `NAMESPACE` and `ENVIRONMENT` variables.

### Development Environment
- `NAMESPACE=dev-monitoring`
- `ENVIRONMENT=development`

### Staging Environment
- `NAMESPACE=stg-monitoring`
- `ENVIRONMENT=staging`

## Check Rsources
```
kubectl get pods,deployments,services,configmaps,persistentvolumeclaim,storageclass,namespaces,serviceaccount --show-labels --namespace ${NAMESPACE}
```

## Enjoy Observing Rolling Update during the Deployment
Run the following command before `kubectl apply` to observe how kubernetes detects new configurations and does rolling update ([Thanks to kustomize](https://github.com/kubernetes-sigs/kustomize/tree/master/examples/helloWorld#rolling-updates)).
```
watch -n 5 'kubectl get pods,deployments,configmaps --show-labels --namespace ${NAMESPACE}'
```

## Access Promethus Dashboard
```
PROM_SERVER_POD_NAME=$(kubectl get pods --namespace ${NAMESPACE} -l "name=prometheus" -l "variant=${ENVIRONMENT}" -o jsonpath="{.items[0].metadata.name}") && \
echo $PROM_SERVER_POD_NAME && \
kubectl port-forward ${PROM_SERVER_POD_NAME} 9090:9090 --namespace ${NAMESPACE}
```

## Check Prometheus Server Logs
```
brew install stern
stern prometheus --namespace ${NAMESPACE}
```

## Check CPU/Memory Requests and Limits
```
kubectl describe nodes
```

## Check Actual Resource Usage
```
kubectl top pod --namespace ${NAMESPACE}
```
