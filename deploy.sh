docker build -t jfbill/multi-client:latest -t jfbill/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jfbill/multi-server:latest -t jfbill/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jfbill/multi-worker:latest -t jfbill/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jfbill/multi-client:latest
docker push jfbill/multi-server:latest
docker push jfbill/multi-worker:latest

docker push jfbill/multi-client:$SHA
docker push jfbill/multi-server:$SHA
docker push jfbill/multi-worker:$SHA

curl -sL https://ibm.biz/idt-installer | bash 
ibmcloud login --apikey vVhU4H2-OHWPAZF26lm4fqcvzYKBlm9zGgVl_uyWbnqd -a cloud.ibm.com -r us-south -g Default
ibmcloud plugin update kubernetes-service
ibmcloud ks cluster-config --cluster blrb3vkd01blsvng8atg
export KUBECONFIG=/Users/Jack.Billings@ibm.com/.bluemix/plugins/container-service/clusters/blrb3vkd01blsvng8atg/kube-config-dal10-complex-cluster.yml

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jfbill/multi-server:$SHA
kubectl set image deployments/client-deployment client=jfbill/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jfbill/multi-worker:$SHA