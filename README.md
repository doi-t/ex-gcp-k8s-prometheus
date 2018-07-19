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
[Rolling updates with new configMap name](https://github.com/kubernetes-sigs/kustomize/tree/master/examples/helloWorld#rolling-updates) will happen.

MEMO: Recreating Prometheus server pod with rolling update for every single config update would cause "holes" in time series metrics as a discussion in https://github.com/kubernetes-sigs/kustomize/issues/50.

### Deploy Development Environment
```
make ENVIRONMENT=development apply
```

### Deploy Staging Environment
```
make ENVIRONMENT=staging apply
```

## Destroy Promethus Server to GKE

### Destroy Development Environment
```
make ENVIRONMENT=development destroy
```

### Destroy Staging Environment
```
make ENVIRONMENT=staging destroy
```
