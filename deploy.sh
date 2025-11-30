#!/bin/bash

# Replace IMAGE_TAG with BUILD_NUMBER
sed -i "s|IMAGE_TAG|${BUILD_NUMBER}|g" deployment.yaml

# Apply manifests
kubectl apply -f deployment.yaml -n dev
kubectl apply -f service.yaml -n dev

# Status
kubectl get pods -n dev
kubectl get svc -n dev
kubectl get deployments -n dev