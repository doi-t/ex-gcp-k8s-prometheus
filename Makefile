ENVIRONMENT:=

apply:
	kustomize build overlays/$(ENVIRONMENT) | kubectl apply -f -

destroy:
	kustomize build overlays/$(ENVIRONMENT) | kubectl delete -f -

get:
	kubectl get pods,deployments,services,endpoints,configmaps,persistentvolumeclaim,storageclass,namespaces,serviceaccount --show-labels --namespace $(ENVIRONMENT)-monitoring

watch:
	watch -n 5 'kubectl get pods,deployments,services,endpoints,configmaps,persistentvolumeclaim,storageclass,namespaces,serviceaccount --show-labels --namespace $(ENVIRONMENT)-monitoring'

forward-prometheus:
	./scripts/forward_prometheus.sh

forward-alertmanager:
	./scripts/forward_alertmanager.sh

tail-prometheus:
	stern prometheus --tail 50 --namespace ${ENVIRONMENT}-monitoring

tail-alertmanager:
	stern alertmanager --tail 50 --namespace ${ENVIRONMENT}-monitoring

describe-nodes:
	kubectl describe nodes

events:
	kubectl get events --namespace $(ENVIRONMENT)-monitoring

top:
	kubectl top pod --namespace $(ENVIRONMENT)-monitoring

busybox:
	kubectl run -it --rm --restart=Never busybox --image=busybox sh --namespace $(ENVIRONMENT)-monitoring
