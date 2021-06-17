FROM controller.trafficserver.org/ats/centos:8

ARG username
ARG userid
ARG git_username
ARG git_email

RUN yum install -y glibc-locale-source glibc-langpack-en
RUN localedef -i en_US -f UTF-8 en_US.UTF-8

# User-specific specifications.
RUN yum install -y sudo vim the_silver_searcher tmux man-pages

# To build the docs.
RUN yum install -y java

RUN useradd \
    --home-dir /home/$username \
    --gid users \
    --uid $userid \
    --shell /bin/bash \
    --create-home \
    $username
RUN echo "$username ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $username
WORKDIR /home/$username
RUN mkdir -p bin

COPY \
    /build_ats \
    /build_ats_core \
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

RUN echo "source /opt/rh/gcc-toolset-9/enable" >> /home/$username/.bashrc
