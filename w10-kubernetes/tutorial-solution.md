# README — Kubernetes Lab

## 0) Setup EC2 for Minikube
```bash
sudo su -
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client

yum install -y docker
service docker start

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
install minikube-linux-amd64 /usr/local/bin/minikube
minikube start --force
minikube status
kubectl get po -A
```

---

## 1) To-Do App Deployment
```bash
kubectl run todolistapp --image=tomhuynhsg/react-todo-list-app
kubectl expose pod todolistapp --type=NodePort --port=80 --name=todolistapp-service
kubectl get svc todolistapp-service

minikube service todolistapp-service --url
kubectl port-forward svc/todolistapp-service 3000:80 --address 0.0.0.0 &
```

---

## 2) Kubernetes Dashboard
### Option A (proxy)
```bash
kubectl proxy --address='0.0.0.0' --accept-hosts='.*' &
# Access: http://<EC2-IP>:8001/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/
```

### Option B (SSH tunnel)
```bash
ssh -i <key.pem> -L 8081:localhost:<remote-port> ec2-user@<EC2-IP>
```

---

## 3) Voting App Deployment with Manifests
```bash
git clone https://github.com/TomHuynhSG/simple-voting-application.git
cd simple-voting-application/kubernetes

kubectl create -f voting-app-pod.yml
kubectl create -f voting-app-service.yml
kubectl port-forward svc/voting-service 3001:80 --address 0.0.0.0 &

kubectl create -f redis-pod.yml
kubectl create -f redis-service.yml

kubectl create -f postgres-pod.yml
kubectl create -f postgres-service.yml

kubectl create -f worker-app-pod.yml

kubectl create -f result-app-pod.yml
kubectl create -f result-app-service.yml
kubectl port-forward svc/result-service 3002:80 --address 0.0.0.0 &
```

Deploy everything in one go:
```bash
kubectl create -f .
kubectl get pods
kubectl get services
```

Cleanup:
```bash
kubectl delete -f .
minikube stop
minikube delete
```