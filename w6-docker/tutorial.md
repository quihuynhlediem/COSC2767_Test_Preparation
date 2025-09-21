# Docker Tutorials

## Docker Command Lines
1. View current available images
```bash
docker images
```
2. View current running containers
```bash
docker ps
```
ps stands for process status
3. Run an image (the container will be removed intermediately after running)
```bash
docker run <image_name> 
```
4. List all containers despite their statuses
```bash
docker ps -a 
```
5. Remove a container
```bash
docker rm <container_id> #View by docker ps
```
5. Remove an image
```bash
docker rmi <image_id> #View by docker images
```
6. Pull an image
```bash
docker pull <image_name> 
```
7. Run a container with port and image, container name
```bash
docker run -d --name <container_name> --p <outside_port>:<inside-port> <image-name>
```
8. Stop a container
```bash
docker stop <container_name>
```
9. Start a container
```bash
docker start <container_name> 
```
10. Build an image from Dockerfle
```bash
docker build -t <image-name> <Dockerfile-location> 
```
11. Create service:
```bash
docker service create --name <service_name> --replicas <number_of_replica> -p <port>:<port> --mount type=volume,source=<volume_source>,destination=<volume_destination_in_container> <image_name> 
```
## Integrate with Jenkins 
**Prequitesite**: Add user dockeradmin
0. Add a Dockerfile to /home/dockeradmin
1. Plugins: Publish over SSH
2. System: Add server
<img src="./images/ssh-configure.png">
3. Job Configure - Add server and execute shell
```bash
cd /home/dockeradmin

docker kill $(docker ps -q)
docker system prune -f

docker build -t tomcat:v2 .
docker run -d --name tomcat-container-final -p 8087:8080 tomcat:v2 
```
<img src="./images/job-configure-for-ssh.png">

## Challenge 1
### Step 1: Modify the Application to Generate Logs
Add inside div tag of /src/main/webapp/index.jsp (on local github)
```bash
<%-- Add this logging code --%>
<%@ page import="java.io.*, java.util.Date, java.text.SimpleDateFormat" %>
<%
    try {
        // Define the path for the log file inside the container
        String logDirPath = "/usr/local/tomcat/logs";
        String logFilePath = logDirPath + "/app.log";

        // Ensure the log directory exists
        File logDir = new File(logDirPath);
        if (!logDir.exists()) {
            logDir.mkdirs();
        }

        // Open the log file in append mode (the 'true' flag)
        PrintWriter outLog = new PrintWriter(new FileWriter(logFilePath, true));
        
        // Create a timestamp
        String timestamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        
        // Write the log entry
        outLog.println(timestamp + " - Page accessed by a user.");
        
        // IMPORTANT: Close the writer to save the changes
        outLog.close();
    } catch (IOException e) {
        // Basic error handling
        e.printStackTrace();
    }
%>
<p style="color: green;"><b>A new log entry was just added to /usr/local/tomcat/logs/app.log!</b></p>

```
### Step 2: Update the Jenkins Job for Volumes
Update at **Execute Shell**
```bash
# Change to the dockeradmin user's home directory where the Dockerfile and .war file are
cd /home/dockeradmin

# Create a named volume for persistent logs. The '|| true' prevents an error if it already exists.
docker volume create my-app-logs || true

# Build a new version of the image
docker build -t tomcat:v3 .

# Stop and remove the old container if it exists, to free up the name
docker stop tomcat-container-final-v3 || true
docker rm tomcat-container-final-v3 || true

# Run the new container, mapping the volume to the logs directory
# We use port 8088 for this version
docker run -d --name tomcat-container-final-v3 -p 8088:8080 \
  -v my-app-logs:/usr/local/tomcat/logs \
  tomcat:v3

```
### Step 3: Run the Build and Test the Application
- Remove all current images and containers (if I can)
- Rerun build job
- Test by 
```bash
docker exec -it <container_name> cat ./logs/app.log 
```
## Challenge 2
### Step 1: Switch to Swarm mode
```bash
docker swarm init
```
### Step 2: Create Swarm Service
```bash
docker service create \
  --name my-webapp \
  --replicas 3 \
  -p 8090:8080 \
  --mount type=volume,source=my-app-logs,destination=/usr/local/tomcat/logs \
  tomcat:v3
```
### Test Swarm
```bash
docker service ps my-webapp
```
### Extra: Work in sample instance
1. On EC2, grant access by add jenkins users to the docker groups
```bash
usermod -aG docker jenkins
systemctl restart jenkins 
```
2. Execute shell
```bash
#!/usr/bin/env bash
set -euo pipefail

WAR_FILE=$(ls -1 target/*.war | head -n 1)
APP_NAME="my-tomcat-app"
IMAGE_NAME="my-tomcat-app"
IMAGE_TAG="${BUILD_NUMBER}"
REGISTRY=""                              # e.g. "your-dockerhub-user" or "1234567890.dkr.ecr.ap-southeast-1.amazonaws.com"
FULL_IMAGE="${REGISTRY:+${REGISTRY}/}${IMAGE_NAME}:${IMAGE_TAG}"
PORT="8088"
CONTAINER_NAME="${APP_NAME}-v${BUILD_NUMBER}"

echo "Build image: ${FULL_IMAGE}"
docker build -t "${FULL_IMAGE}" .

# Optional: push to registry (uncomment if needed)
#: <<'PUSH'
#if [ -n "${REGISTRY}" ]; then
#  echo "Login & Push"
#  echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin "${REGISTRY}"
#  docker push "${FULL_IMAGE}"
#fi
#PUSH

echo "Stop/remove old containers"
old_id=$(docker ps -aq --filter "name=^/${APP_NAME}-v" || true)
if [ -n "${old_id}" ]; then
  docker rm -f ${old_id} || true
fi

echo "Run new container ${CONTAINER_NAME} on host port ${PORT}"
docker run -d --name "${CONTAINER_NAME}" -p "${PORT}:8080" "${FULL_IMAGE}"

docker cp "$WAR_FILE" "${CONTAINER_NAME}:/usr/local/tomcat/webapps"

# Optional cleanup
docker image prune -f || true 
```