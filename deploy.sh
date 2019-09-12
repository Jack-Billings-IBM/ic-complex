docker build -t us.icr.io/jb-namespace/fib-repo:multi-client:latest -t us.icr.io/jb-namespace/fib-repo:multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t us.icr.io/jb-namespace/fib-repo:multi-server:latest -t us.icr.io/jb-namespace/fib-repo:multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t us.icr.io/jb-namespace/fib-repo:multi-worker:latest -t us.icr.io/jb-namespace/fib-repo:multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push us.icr.io/jb-namespace/fib-repo:multi-client:latest
docker push us.icr.io/jb-namespace/fib-repo:multi-server:latest
docker push us.icr.io/jb-namespace/fib-repo:multi-worker:latest

docker push us.icr.io/jb-namespace/fib-repo:multi-client:$SHA
docker push us.icr.io/jb-namespace/fib-repo:multi-server:$SHA
docker push us.icr.io/jb-namespace/fib-repo:multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=us.icr.io/jb-namespace/fib-repo:multi-server:$SHA
kubectl set image deployments/client-deployment client=us.icr.io/jb-namespace/fib-repo:multi-client:$SHA
kubectl set image deployments/worker-deployment worker=us.icr.io/jb-namespace/fib-repo:multi-worker:$SHA