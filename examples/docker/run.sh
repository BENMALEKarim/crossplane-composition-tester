#!/bin/bash
docker network create crossplane-net

docker run --network crossplane-net -d --name function-environment-configs xpkg.upbound.io/crossplane-contrib/function-environment-configs:v0.1.0 --insecure --address=:9443
docker run --network crossplane-net -d --name function-auto-ready xpkg.upbound.io/crossplane-contrib/function-auto-ready:v0.3.0 --insecure --address=:9443
docker run --network crossplane-net -d --name function-go-templating xpkg.upbound.io/crossplane-contrib/function-go-templating:v0.7.0 --insecure --address=:9443

docker run --rm --network crossplane-net -v ../test/:/app/test/ -v ../allure-results:/app/allure-results crossplane-composition-tester:v0.0.1 behave test/composition-tests -f allure_behave.formatter:AllureFormatter -o /app/allure-results -f pretty