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

# Init mpl fonts
RUN MPLBACKEND=Agg python -c "import matplotlib.pyplot"

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

ADD https://static.geonet.org.nz/cwb/GeoNetCWBQuery-4.2.0-bin.jar /usr/local/bin/GeoNetCWBQuery-4.2.0-bin.jar

RUN chmod a+rx /usr/local/bin/GeoNetCWBQuery-4.2.0-bin.jar

# Configure container startup
ENTRYPOINT ["tini", "--"]

VOLUME ["/output"]
VOLUME ["/workdir"]
COPY *.py /usr/local/bin/
COPY *.csh /usr/local/bin/
COPY *.sh /usr/local/bin/

