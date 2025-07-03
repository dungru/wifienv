# Getting Start
Install docker from the website https://docs.docker.com/engine/install/

## Add user to docker group
```
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
docker run hello-world
```


# wifienv
## Build 18.04 Docker
- Build the docker Image
  `./dockerq build`

- Copy the dockerq to /usr/bin
    `sudo cp dockerq /usr/bin/`

- Start to use the build environment
    `dockerq <your makefile command>`

## Build 22.04 Docker
- Build the docker Image
  `./dockerq22 build`

- Copy the dockerq to /usr/bin
    `sudo cp dockerq22 /usr/bin/`

- Start to use the build environment
    `dockerq22 <your makefile command>`