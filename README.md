# Getting Start
Install docker from the website https://docs.docker.com/engine/install/
![image](https://github.com/user-attachments/assets/2e2b5f7f-5dcd-4b67-8776-f95e778b2b46)

## Add user to docker group
```
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
docker run hello-world
```


# wifienv
- Build the docker Image

  `./dockerq build`
- Copy the dockerq to /usr/bin

    `sudo cp dockerq /usr/bin/`
- Start to use the build environment

    `dockerq <your makefile command>`
