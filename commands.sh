# add user to docker group (to run without sudo)
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# step 0 - create 2 NetCat scripts: one per container (wtf is netcat?)
echo -e "#!/bin/sh\n\n# connect TCP to port 5000 on host IP\n# provided as 1st parameter\nnc \$1 5000" > client.sh
echo -e "#!/bin/sh\n\n# listen to the port 5000 for incoming connections\nnc -l -p 5000" > server.sh

# step 1 - create Alpine based image.
docker image build . --tag myalpine

# step 2 - create bridge network.
docker network create --driver bridge interhost

# step 3 - run created Myalpine image as two containers in the intehost network
#          interactively providing volume bind mounts and scripts to run
docker container run --network interhost -v $(pwd):/home/root/scripts/ -it --name host1 myalpine /home/root/scripts/server.sh
docker container run --network interhost -v $(pwd):/home/root/scripts/ -it --name host2 myalpine /home/root/scripts/client.sh 172.18.0.2

# step 4 - input some data on any host container and see it on another
# connection is enabled, you may transmit the data

# cleanup the environment
docker container rm -f host1
docker container rm -f host2
docker network rm interhost
docker image rm myalpine
