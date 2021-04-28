FROM controller.trafficserver.org/ats/centos:8

ARG username
ARG userid

RUN yum install -y sudo vim glibc-locale-source glibc-langpack-en
RUN localedef -i en_US -f UTF-8 en_US.UTF-8

# Install openssl-quic
RUN yum install -y python38-devel
RUN alternatives --set python /usr/bin/python3.8
RUN yum -y install libev-devel jemalloc-devel libxml2-devel \
    c-ares-devel libevent-devel jansson-devel zlib-devel systemd-devel
RUN git clone https://github.com/apache/trafficserver.git; \
    bash trafficserver/tools/build_h3_tools.sh

RUN useradd \
    --home-dir /home/$username \
    --gid users \
    --no-create-home \
    --uid $userid \
    --shell /bin/bash \
    $username

RUN echo "$username ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER my_user
