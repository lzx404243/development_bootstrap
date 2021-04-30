FROM controller.trafficserver.org/ats/centos:8

ARG username
ARG userid

RUN yum install -y glibc-locale-source glibc-langpack-en
RUN localedef -i en_US -f UTF-8 en_US.UTF-8

# Install openssl-quic
RUN yum install -y python38-devel
RUN alternatives --set python /usr/bin/python3.8
RUN yum -y install libev-devel jemalloc-devel libxml2-devel \
    c-ares-devel libevent-devel jansson-devel zlib-devel systemd-devel
COPY /build_h3_tools.sh /var/tmp/build_h3_tools.sh
RUN bash /var/tmp/trafficserver/tools/build_h3_tools.sh

# User-specific specifications.
RUN yum install -y sudo vim the_silver_searcher

RUN useradd \
    --home-dir /home/$username \
    --gid users \
    --uid $userid \
    --shell /bin/bash \
    $username
RUN echo "$username ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $username
WORKDIR /home/$username
RUN mkdir -p bin
COPY \
    /build_ats \
    /build_ats_not_quic \
    /start_ats_project \
    /home/$username/bin
RUN chmod 755 /home/$username/bin/*

COPY \
    .aliases \
    .bashrc \
    .editrc \
    .git-completion.bash \
    .git-prompt.sh \
    .gitconfig \
    .inputrc \
    .tmux.conf \
    .vim \
    .vimrc \
    /home/$username/

WORKDIR .vim
RUN mkdir bundle
WORKDIR bundle

# Check these out at specific revisions so things do not
# change across new docker builds.
RUN \
    git clone https://github.com/dense-analysis/ale.git; \
    git checkout d81986a1; \
    git clone git://github.com/ntpeters/vim-better-whitespace.git; \
    git checkout 8cf4b21; \
    git clone git://github.com/will133/vim-dirdiff; \
    git checkout 0191693; \
    git clone https://github.com/tpope/vim-fugitive.git; \
    git checkout 8f4a23e

WORKDIR /home/$username
