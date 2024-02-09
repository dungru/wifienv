FROM ubuntu:18.04

# Install required packages and dependencies
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    build-essential \
    make \
    gawk \
    wget \
    git-core \
    diffstat \
    unzip \
    texinfo \
    chrpath \
    socat \
    bison \
    curl \
    cpio \
    python3 \
    python3-pip \
    python3-pexpect \
    xz-utils \
    debianutils \
    iputils-ping \
    python3-git \
    python3-jinja2 \
    libegl1-mesa \
    libsdl1.2-dev \
    pylint3 \ 
    xterm \
    locales \
    cmake \
    gcc-7-aarch64-linux-gnu \
    gcc-aarch64-linux-gnu \
    device-tree-compiler \
    lib32stdc++6 libevent-dev libpulse-dev libsdl1.2-dev libstdc++6 ninja-build python3-pexpect rpm2cpio socat texinfo libdivsufsort-dev libbz2-dev \
    uuid-dev clang-6.0 clang-format \
    gettext libfile-slurp-perl libncurses-dev autoconf doxygen libtool automake libpcre3-dev libbz2-dev subversion minicom putty rpm python-pexpect \
    python-svn python-argparse tofrodos meld dos2unix ruby transfig libglib2.0-dev xutils-dev autopoint python-dulwich python-dev cpio python-yaml swig
# Install JAVA
## This is in accordance to : 
##     https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-get-on-ubuntu-16-04
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y ant && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/oracle-jdk8-installer;

## Fix certificate issues, found as of 
##     https://bugs.launchpad.net/ubuntu/+source/ca-certificates-java/+bug/983302
RUN apt-get update && \
    apt-get install -y ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/oracle-jdk8-installer;

# Settings
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8   
## Setup JAVA_HOME, this is useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

## RUN echo America/Los_Angeles |  tee /etc/timezone &&  dpkg-reconfigure --frontend noninteractive tzdata
ARG DEBIAN_FRONTEND=noninteractive

# COPY the necessary files
COPY repo_cmd /usr/local/bin/repo
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY gosu /bin/gosu
# Define the entry point
RUN chmod +x /usr/local/bin/repo
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
