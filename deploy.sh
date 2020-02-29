docker build -t vvyacheslav/multi-client:latest -t vvyacheslav/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vvyacheslav/multi-server:latest -t vvyacheslav/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vvyacheslav/multi-worker:latest -t vvyacheslav/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vvyacheslav/multi-client:latest
docker push vvyacheslav/multi-server:latest
docker push vvyacheslav/multi-worker:latest

docker push vvyacheslav/multi-client:$SHA
docker push vvyacheslav/multi-server:$SHA
docker push vvyacheslav/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vvyacheslav/multi-server:$SHA
kubectl set image deployments/client-deployment client=vvyacheslav/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vvyacheslav/multi-worker:$SHA