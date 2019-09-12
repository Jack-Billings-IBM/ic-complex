docker build -t us.icr.io/jb-namespace/fib-repo:multi-client:latest -t us.icr.io/jb-namespace/fib-repo:multi-client:$SHA -f ./client/Dockerfile ./client

# docker push us.icr.io/jb-namespace/fib-repo:latest

# docker push us.icr.io/jb-namespace/fib-repo:$SHA

kubectl apply -f k8s
# kubectl set image deployments/server-deployment server=us.icr.io/jb-namespace/fib-repo:multi-server:$SHA
# kubectl set image deployments/client-deployment client=us.icr.io/jb-namespace/fib-repo:multi-client:$SHA
# kubectl set image deployments/worker-deployment worker=us.icr.io/jb-namespace/fib-repo:multi-worker:$SHA