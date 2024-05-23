# PROJECT 'DOCKER'

## Description
This projects demonstrates Docker functionality. Consists of ```Dockerfile```, two scripts```server.sh``` & ```client.sh```.
Also ```commands.sh``` provided as an usage example.

```server.sh``` contains simple NetCat command to listen port 5000 on incoming connections.
```client.sh``` takes one parameter - server IP address - and use NetCat to setup TCP connection with server.
```Dockerfile``` - contains small image decription and used to built "myalpine" image.

## How to use
After you get the sources on your machine, you may try this program on your system. Follow instructions below.

#### Step 0. Install Docker and add yourself to "docker" group:
```
sudo apt install docker
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker # or you may just re-login
```

#### Step 1. Build the image:
```
docker image build . --tag myalpine
```
#### Step 2. Create bridge type Docker-network:
```
docker network create --driver bridge interhost
```
#### Step 3. Run server container:
```
docker container run --network interhost -v $(pwd):/home/root/scripts/ -it --name host1 myalpine /home/root/scripts/server.sh
```
#### Step 4. Run client container (providing IP address of server):
```
docker container run --network interhost -v $(pwd):/home/root/scripts/ -it --name host2 myalpine /home/root/scripts/client.sh 172.18.0.2
```
#### Step 5. Enjoy communication between them:
At this point when you type anything in one host and push "Enter", it should appear on the other.
Data transmission is working.

#### Step 6. After all, in case you need to remove everything:
```
docker container rm -f host1
docker container rm -f host2
docker network rm interhost
docker image rm myalpine
```

> [!NOTE]
> Docker works with Linux kernel features that require root priviligies. You have either run each docker command with ```sudo```, or add your user to ```docker``` group, and Docker daemon will provide you with access.

## For maintainers
When making changes in the project, do not forget to update the README.md.

## Out contacts
In case of emergency you may contact us via:
> E-mail: echo@laptop.com
