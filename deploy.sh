#!/bin/bash

# Replace IMAGE_TAG
sed -i "s|IMAGE_TAG|${BUILD_NUMBER}|g" deployment.yaml

# Apply deployment & service
kubectl apply -f deployment.yaml -n dev
kubectl apply -f service.yaml -n dev

# Rollout status
kubectl rollout status deployment/taxiapp -n dev

# Show pods and service
kubectl get pods -n dev
kubectl get svc -n dev
