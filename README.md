# sap-nw-abap-docker
SAP NetWeaver ABAP Developer Edition in Docker

# Installation

A detailed blog on how to get this image and container up and running can be found on my blog: [DOCKERFILE FOR SAP NETWEAVER ABAP 7.5X DEVELOPER EDITION](https://www.itsfullofstars.de/2017/09/dockerfile-for-sap-netweaver-abap-7-5x-developer-edition/)

To be able to setup the Docker container with just one command, make sure to read my blog [ADJUST IMAGE SIZE OF DOCKER QCOW2 FILE
](https://www.itsfullofstars.de/2017/12/adjust-the-image-size-of-docker/). SAP NetWeaver is somewhat too large for Docker, and you can get a no space left on device error when installing it on a default Docker installation. The blog expains how to increase the Docker image file size by 100G, allowing to setup SAP NetWeaver ABAP by just running docker build -t abap .

## Short version

1. Download your version of [SAP NetWeaver ABAP 7.5x Developer Edition from SAP](https://tools.hana.ondemand.com/#abap). The files are compressed (RAR). Un-compress them into a folder named NW751. The folder must be at the same location where your Dockerfile is.

2. Build the Docker image

```sh
docker build -t nwabap .
```

3. Start container

```sh
docker run -P -h vhcalnplci --name nwabap751 -it nwabap:latest /bin/bash
```

4. Start NetWeaver installation

```sh
run.sh
```

5. Done. NetWeaver ABAP is installed and ready to be used. Users, credentials, etc can be found in the fie readme.html shipped with the NetWeaver ABAP RAR files.
