# Docker Swarm Lab (with Docker Compose warm-up)

## 0) EC2 (single host) for Compose warm-up
### Setup
```bash
sudo su -
yum install -y git docker
service docker start
git clone https://github.com/TomHuynhSG/simple-voting-application.git
cd simple-voting-application
```

### Run components with plain Docker
```bash
cd vote
docker build . -t voting-app
docker run -d --name voting-container -p 8080:80 --link redis:redis voting-app

docker run -d --name=redis redis
docker run -d --name=db -e POSTGRES_PASSWORD=postgres postgres:9.4

cd ../worker
docker build . -t worker-app
docker run -d --name worker-container --link redis:redis --link db:db worker-app

cd ../result
docker build . -t result-app
docker run -d --name result-container -p 8081:80 --link db:db result-app
```

### Docker Compose version
```bash
curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)   -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose version
docker-compose up -d
docker-compose down
```

---

## 1) Docker Swarm Setup
```bash
# On all nodes
yum install -y docker
service docker start

# On manager
docker swarm init

# On workers
docker swarm join --token <token> <manager-ip>:2377

# Back on manager
docker node ls
```

---

## 2) Swarm Services
```bash
docker service create nginx
docker service update <service-id> --publish-add 8080:80

docker service rm <service-id>
docker service create --name nginx --replicas 2 --publish published=8080,target=80 nginx

docker service ps nginx
docker node update --availability drain docker-master
```

---

## 3) Load Balancer (AWS ALB)
- Create an ALB (internet-facing, port 8080)
- Target group: docker-worker-1, docker-worker-2 on port 8080
- Use ALB DNS to access replicated nginx service
```

---

## (Bonus) Prometheus with Docker Compose
- Add Prometheus service in docker-compose.yml
- Expose `/metrics` from vote app
- Query `app_votes_total` in Prometheus UI