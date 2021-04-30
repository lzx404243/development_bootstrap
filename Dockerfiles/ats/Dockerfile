FROM controller.trafficserver.org/ats/centos:8

ARG username
ARG userid
ARG git_username
ARG git_email

RUN yum install -y glibc-locale-source glibc-langpack-en
RUN localedef -i en_US -f UTF-8 en_US.UTF-8

# Install openssl-quic
RUN yum install -y python38-devel
RUN alternatives --set python /usr/bin/python3.8
RUN yum -y install libev-devel jemalloc-devel libxml2-devel \
    c-ares-devel libevent-devel jansson-devel zlib-devel systemd-devel
COPY /build_h3_tools.sh /var/tmp/build_h3_tools.sh
RUN bash /var/tmp/build_h3_tools.sh

# User-specific specifications.
RUN yum install -y sudo vim the_silver_searcher tmux

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
    /home/$username/bin/

# Alas, COPY is not run as USER, and older docker version do not have --chown
# for COPY.
RUN \
    sudo chown $username:nobody /home/$username/bin/*; \
    chmod 755 /home/$username/bin/*

COPY \
    .aliases \
    .bashrc \
    .editrc \
    .git-completion.bash \
    .git-prompt.sh \
    .gitconfig \
    .inputrc \
    .tmux.conf \
    .vimrc \
    /home/$username/

RUN mkdir .vim
COPY .vim .vim

RUN mkdir .git_template
COPY .git_template .git_template

RUN \
    sudo chown -R $username:nobody \
        .aliases \
        .bashrc \
        .editrc \
        .git-completion.bash \
        .git-prompt.sh \
        .gitconfig \
        .git_template \
        .inputrc \
        .tmux.conf \
        .vim \
        .vimrc


WORKDIR .vim
RUN mkdir bundle
WORKDIR bundle

# Check these out at specific revisions so things do not
# change across new docker builds.
RUN \
    git clone https://github.com/dense-analysis/ale.git; \
    cd ale; \
    git checkout d81986a1; \
    cd ../; \
    git clone git://github.com/ntpeters/vim-better-whitespace.git; \
    cd vim-better-whitespace; \
    git checkout 8cf4b21; \
    cd ../; \
    git clone git://github.com/will133/vim-dirdiff; \
    cd vim-dirdiff; \
    git checkout 0191693; \
    cd ../; \
    git clone https://github.com/tpope/vim-fugitive.git; \
    cd vim-fugitive; \
    git checkout 8f4a23e; \
    cd ../

WORKDIR /home/$username
RUN  \
  git config --global user.name "$git_username"; \
  git config --global user.email $git_email
