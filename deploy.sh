docker build -t vivek170161/multi-client:latest -t vivek170161/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vivek170161/multi-server:latest -t vivek170161/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vivek170161/multi-worker:latest -t vivek170161/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vivek170161/multi-client:latest
docker push vivek170161/multi-server:latest
docker push vivek170161/multi-worker:latest

docker push vivek170161/multi-client:$SHA
docker push vivek170161/multi-server:$SHA
docker push vivek170161/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployements/client-deployment client=vivek170161/multi-client:$SHA
kubectl set image deployements/server-deployment server=vivek170161/multi-server:$SHA
kubectl set image deployements/worker-deployment worker=vivek170161/multi-worker:$SHA