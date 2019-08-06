# sap-nw-abap-docker

SAP NetWeaver ABAP Developer Edition in Docker.

The Dockerfile works for the NW750 and NW751 as well as for the new (Sep 2018) NW752 trial from SAP. To install the NetWeaver 7.52 SP01 trial, use the Dockerfile and store the downloaded and extracted rar files from SAP in the folder NW752.

# Installation

A detailed blog on how to get this image and container up and running can be found on my blog: [DOCKERFILE FOR SAP NETWEAVER ABAP 7.5X DEVELOPER EDITION](https://www.itsfullofstars.de/2017/09/dockerfile-for-sap-netweaver-abap-7-5x-developer-edition/)

To be able to setup the Docker container with just one command, make sure to read my blog [ADJUST IMAGE SIZE OF DOCKER QCOW2 FILE
](https://www.itsfullofstars.de/2017/12/adjust-the-image-size-of-docker/). SAP NetWeaver is somewhat too large for Docker, and you can get a no space left on device error when installing it on a default Docker installation. The blog expains how to increase the Docker image file size by 100G, allowing to setup SAP NetWeaver ABAP by just running docker build -t abap .

## Short version

1. Download your version of [SAP NetWeaver ABAP 7.5x Developer Edition from SAP](https://tools.hana.ondemand.com/#abap). The files are compressed (RAR). Un-compress them into a folder named NW752. The folder must be at the same location where your Dockerfile is.

2. Build the Docker image

This will install NW ABAP.

```sh
docker build -t nwabap .
```

3. Start container

```sh
docker run -P -h vhcalnplci --name nwabap752 -it nwabap:latest /bin/bash
```

4. Start NetWeaver

The above command will start the container and open a command prompt. While SAP NetWeaver ABAP is installed, it is not started automatically by the image. You need to start the server manually.

```sh
startsap
```

In case NW won't start and give an error like: 

```sh
No instance profiles found

please send the tracefile /home/npladm/startsap.trc to support
```

Take a look at the hostname that SAP is using for the intsance. 

```sh
more /usr/sap/NPL/SYS/profile/DEFAULT.PFL
```

Look for an entry like SAPGLOBALHOST = d0bbd590312c

In this case, the hostname sapstart is expecting is d0bbd590312c. Set the hostname of the container d0bbd590312c in /etc/hostname and it to /etc/hosts. Calling sapstart again should work, as the hostname is now correctly configured.

5. Done. NetWeaver ABAP is installed and ready to be used. Users, credentials, etc can be found in the fie readme.html shipped with the NetWeaver ABAP RAR files.
