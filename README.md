# sap-nw-abap-docker
SAP NetWeaver ABAP Developer Edition in Docker

# Installation

A detailed blog on how to get this image and container up and running can be found on my blog: [DOCKERFILE FOR SAP NETWEAVER ABAP 7.5X DEVELOPER EDITION](https://www.itsfullofstars.de/2017/09/dockerfile-for-sap-netweaver-abap-7-5x-developer-edition/)

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
