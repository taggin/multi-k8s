docker build -t kacperb/multi-client:latest -t kacperb/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kacperb/multi-server:latest -t kacperb/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kacperb/multi-worker:latest -t kacperb/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kacperb/multi-client:latest
docker push kacperb/multi-server:latest
docker push kacperb/multi-worker:latest

docker push kacperb/multi-client:$SHA
docker push kacperb/multi-server:$SHA
docker push kacperb/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kacperb/multi-server:$SHA
kubectl set image deployments/client-deployment client=kacperb/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kacperb/multi-worker:$SHA