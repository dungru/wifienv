# syntax=docker/dockerfile:1

# Default Ubuntu version is 18.04
ARG UBUNTU_VERSION=18.04
FROM ubuntu:${UBUNTU_VERSION}

ARG UBUNTU_VERSION
ARG DEBIAN_FRONTEND=noninteractive

# Common packages
RUN apt-get update && apt-get install -y \
    build-essential \
    make \
    gawk \
    wget \
    git \
    git-core \
    diffstat \
    flex \
    unzip \
    texinfo \
    chrpath \
    socat \
    swig \
    bison \
    bc \
    libssl-dev \
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
    xterm \
    locales \
    cmake \
    rsync \
    gcc-aarch64-linux-gnu \
    device-tree-compiler \
    python3-subunit \
    mesa-common-dev \
    zstd \
    liblz4-tool \
    file \
    libacl1 \
    lib32stdc++6 \
    libevent-dev \
    libpulse-dev \
    libstdc++6 \
    ninja-build \
    rpm2cpio \
    socat \
    texinfo \
    libdivsufsort-dev \
    libbz2-dev \
    uuid-dev \
    gettext \
    libfile-slurp-perl \
    libncurses-dev \
    autoconf \
    doxygen \
    libtool \
    automake \
    libpcre3-dev \
    subversion \
    minicom \
    putty \
    rpm \
    tofrodos \
    meld \
    dos2unix \
    ruby \
    transfig \
    libglib2.0-dev \
    xutils-dev \
    autopoint \
    cpio \
    swig \
    ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 18.04 specific packages
RUN if [ "$UBUNTU_VERSION" = "18.04" ]; then \
    apt-get update && \
    apt-get install -y \
        python-dev \
        pylint3 \
        gcc-arm-linux-gnueabi \
        gcc-7-aarch64-linux-gnu \
        python-pexpect \
        python-svn \
        python-argparse \
        python-dulwich \
        python-dev \
        python-yaml \
    && apt-get clean && rm -rf /var/lib/apt/lists/* ; \
fi

# 22.04 specific packages
RUN if [ "$UBUNTU_VERSION" = "22.04" ]; then \
    apt-get update && \
    apt-get install -y \
        python3-dev \
        python3-setuptools \
        gcc-11-aarch64-linux-gnu \
        python3-pyelftools \
        libnuma-dev \
        libpcap-dev \
        meson \
        pkg-config \
        tar \
        net-tools \
        tcpreplay \
        zlib1g-dev \
        python3-distutils \
        g++ \
        gcc \
        clang-15 \
    && apt-get clean && rm -rf /var/lib/apt/lists/* ; \
fi

# 22.04 extra settings
RUN if [ "$UBUNTU_VERSION" = "22.04" ]; then \
    python3 -m pip install --upgrade setuptools pip wheel && \
    pip3 install pyelftools meson && \
    ln -vsnf /usr/lib/llvm-15/bin/clang /usr/bin/clang && \
    ln -vsnf /usr/lib/llvm-15/bin/llc /usr/bin/llc ; \
fi

# Install JAVA (common for both versions)
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk ant && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/oracle-jdk8-installer

# Fix JAVA certificate issues
RUN apt-get update && \
    apt-get install -y ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/oracle-jdk8-installer

# Locale settings
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

# Copy necessary files
COPY repo_cmd /usr/local/bin/repo
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY gosu /bin/gosu

RUN chmod +x /usr/local/bin/repo
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]