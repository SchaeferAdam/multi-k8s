docker build -t adamschaefer/multi-client-k8s:latest -t adamschaefer/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t adamschaefer/multi-server-k8s:latest -t adamschaefer/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t adamschaefer/multi-worker-k8s:latest -t adamschaefer/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push adamschaefer/multi-client-k8s:latest
docker push adamschaefer/multi-server-k8s:latest
docker push adamschaefer/multi-worker-k8s:latest

docker push adamschaefer/multi-client-k8s:$SHA
docker push adamschaefer/multi-server-k8s:$SHA
docker push adamschaefer/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=adamschaefer/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=adamschaefer/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=adamschaefer/multi-worker-k8s:$SHA