BASE_NAMESPACE='monitoring'
ENVIRONMENT:=

apply:
	kustomize build overlays/$(ENVIRONMENT) | kubectl apply -f -

destroy:
	kustomize build overlays/$(ENVIRONMENT) | kubectl delete -f -

get:
	kubectl get pods,deployments,daemonsets,services,endpoints,configmaps,persistentvolumeclaim,storageclass,namespaces,serviceaccount --show-labels --namespace $(ENVIRONMENT)-$(BASE_NAMESPACE)

watch:
	watch -n 5 'kubectl get pods,deployments,daemonsets,services,endpoints,configmaps,persistentvolumeclaim,storageclass,namespaces,serviceaccount --show-labels --namespace $(ENVIRONMENT)-$(BASE_NAMESPACE)'

forward-prometheus:
	./scripts/forward_prometheus.sh

forward-alertmanager:
	./scripts/forward_alertmanager.sh

tail-prometheus:
	stern prometheus --tail 50 --namespace ${ENVIRONMENT}-$(BASE_NAMESPACE)

tail-alertmanager:
	stern alertmanager --tail 50 --namespace ${ENVIRONMENT}-$(BASE_NAMESPACE)

describe-nodes:
	kubectl describe nodes

events:
	kubectl get events --namespace $(ENVIRONMENT)-$(BASE_NAMESPACE)

top:
	kubectl top pod --namespace $(ENVIRONMENT)-$(BASE_NAMESPACE)

busybox:
	kubectl run -it --rm --restart=Never busybox --image=busybox sh --namespace $(ENVIRONMENT)-$(BASE_NAMESPACE)
