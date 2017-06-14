FROM ubuntu:16.04

MAINTAINER Yannik Behr <y.behr@gns.cri.nz>

RUN apt-get update \
 && apt-get -y upgrade || true \
 && apt-get -y install \
    python-matplotlib \
    python-numpy \
    python-scipy \
    wget \
    vim \
    csh \
    openjdk-8-jre

# Install ObsPy    
RUN REPO=http://deb.obspy.org \
 && echo "deb $REPO xenial main\n" >> /etc/apt/sources.list \
 && wget --quiet -O - https://raw.github.com/obspy/obspy/master/misc/debian/public.key | apt-key add - \
 && apt-get update \ 
 && apt-get -y install python-obspy \
 && apt-get clean

# Install Tini
RUN wget --quiet https://github.com/krallin/tini/releases/download/v0.10.0/tini && \
    echo "1361527f39190a7338a0b434bd8c88ff7233ce7b9a4876f3315c22fce7eca1b0 *tini" | sha256sum -c - && \
    mv tini /usr/local/bin/tini && \
chmod +x /usr/local/bin/tini

ADD http://info.geonet.org.nz/download/attachments/8586235/GeoNetCWBQuery-4.2.0-bin.jar /usr/local/bin

RUN chmod a+rx /usr/local/bin/GeoNetCWBQuery-4.2.0-bin.jar

# Configure container startup
ENTRYPOINT ["tini", "--"]

RUN groupadd -g 1260 -r volcano && useradd -m -s /bin/bash -r -g volcano -u 1260 volcano
ENV PATH /home/volcano/scripts:$PATH

USER volcano
WORKDIR /home/volcano
RUN mkdir /home/volcano/scripts

VOLUME ["/home/volcano/output"]
VOLUME ["/home/volcano/sds"]
VOLUME ["/home/volcano/workdir"]
COPY *.py /home/volcano/scripts/
COPY *.csh /home/volcano/scripts/
COPY *.sh /home/volcano/scripts/
