FROM controller.trafficserver.org/ats/centos:8

ARG username
ARG userid

RUN yum install -y sudo vim glibc-locale-source glibc-langpack-en

RUN localedef -i en_US -f UTF-8 en_US.UTF-8

RUN useradd \
    --home-dir /home/$username \
    --gid users \
    --no-create-home \
    --uid $userid \
    --shell /bin/bash \
    $username

RUN echo "$username ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER my_user
