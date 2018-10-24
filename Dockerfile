FROM opensuse:latest

# General information
LABEL de.itsfullofstars.sapnwdocker.version="1.0.0"
LABEL de.itsfullofstars.sapnwdocker.vendor="Tobias Hofmann"
LABEL de.itsfullofstars.sapnwdocker.name="Docker for SAP NetWeaver 7.5x Developer Edition"

# Install dependencies
RUN zypper --non-interactive install --replacefiles uuidd expect tcsh which vim hostname tar net-tools iproute2; \
    zypper clean

# Run uuidd
RUN mkdir /run/uuidd && chown uuidd /var/run/uuidd && /usr/sbin/uuidd

# Copy the downloaded and unrared SAP NW ABAP files to the container
COPY NW752 /var/tmp/NW752/

# We will work from /var/tmp/NW752
WORKDIR /var/tmp/NW752

# Make the install.sh from SAP executable
RUN chmod +x install.sh

# Prepare the shell script to install NW ABAP without asking for user input (using expect)
# Note: Password being used is s@pABAP752
RUN echo $'#!/usr/bin/expect -f \n\
spawn ./install.sh -s -k \n\
set PASSWORD "s@pABAP752"\n\
set timeout -1\n\
expect "Do you agree to the above license terms? yes/no:"\n\
send "yes\\r"\n\
expect "Please enter a password:"\n\
send "$PASSWORD\\r"\n\
expect "Please re-enter password for verification:"\n\
send  "$PASSWORD\\r"\n\
expect eof' >> ./run.sh; chmod +x ./run.sh

# Expose the ports to work with NW ABAP
EXPOSE 8000
EXPOSE 44300
EXPOSE 3300
EXPOSE 3200

# We cannot run the automated installation, as Docker gives no more space left on device error message
# Note: running the script run.sh after the image is created will work
RUN ./run.sh

# The installation files just make the final image bigger.
RUN rm -rf /var/tmp/NW752

# Command sequence to use this Dockerfile

# docker build -t nwabap .
# docker run -P -h vhcalnplci --name nwabap752 -it nwabap:latest /bin/bash
