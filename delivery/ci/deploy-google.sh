#!/bin/bash

docker build -t aldam1r/fib-client:latest -t aldam1r/fib-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t aldam1r/fib-server:latest -t aldam1r/fib-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t aldam1r/fib-worker:latest -t aldam1r/fib-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push aldam1r/fib-client:latest
docker push aldam1r/fib-server:latest
docker push aldam1r/fib-worker:latest

docker push aldam1r/fib-client:$GIT_SHA
docker push aldam1r/fib-server:$GIT_SHA
docker push aldam1r/fib-worker:$GIT_SHA

kubectl apply ./k8s

kubectl set image deployments/client-deployment client=aldam1r/fib-client:$GIT_SHA
kubectl set image deployments/server-deployment server=aldam1r/fib-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=aldam1r/fib-worker:$GIT_SHA
