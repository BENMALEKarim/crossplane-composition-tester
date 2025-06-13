#!/bin/bash

echo "Install functions as deployment and expose them via service"
kubectl apply -f functions.yaml

echo "Launch crossplane-composition-testser job"
kubectl apply -f crossplane-composition-tester.yaml