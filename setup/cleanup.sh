#!/bin/bash

# Use helm to remove the demo application yelb
helm uninstall --namespace yelb-secure yelb-secure

# Use helm to remove the Kube Enforcer
helm uninstall --namespace aqua aqua-kube-enforcer

# Use helm to remove the Aqua Server
helm uninstall --namespace aqua aqua-server

# Remove the existing Kubernetes deployments that would prevent a cluster being
# cleaned up
kubectl delete --namespace kube-system deployment/ebs-csi-controller
kubectl delete --namespace kube-system deployment/coredns

# Put a sleep time in place for all of the eks resources to be cleaned up
echo "Sleeping for 2 minutes while Kubernetes resources are deleted"
sleep 120

# Remove the EKS Cluster
eksctl delete cluster -f setup/cluster.yaml