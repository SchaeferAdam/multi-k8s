docker build -t adamschaefer/multi-client:latest -t adamschaefer/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t adamschaefer/multi-server:latest -t adamschaefer/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t adamschaefer/multi-worker:latest -t adamschaefer/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push adamschaefer/multi-client:latest
docker push adamschaefer/multi-server:latest
docker push adamschaefer/multi-worker:latest
docker push adamschaefer/multi-client:$SHA
docker push adamschaefer/multi-server:$SHA
docker push adamschaefer/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deploymet server=adamschaefer/multi-server:$SHA
kubectl set image deployments/client-deploymet client=adamschaefer/multi-client:$SHA
kubectl set image deployments/worker-deploymet worker=adamschaefer/multi-worker:$SHA
