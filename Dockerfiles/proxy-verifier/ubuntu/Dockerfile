FROM ubuntu:20.04

ARG username
ARG userid
ARG git_username
ARG git_email

# So that installing pkg-config does not interactively prompt during the image
# creation process.
ARG DEBIAN_FRONTEND=noninteractive

# Packages for building Proxy Verifier and its dependencies.
RUN apt-get update; \
    apt-get install -y pipenv autoconf libtool pkg-config git

# Install the library dependencies in /opt.
WORKDIR /var/tmp
RUN \
    git clone https://github.com/yahoo/proxy-verifier.git; \
    cd proxy-verifier; \
    bash tools/build_library_dependencies.sh /opt

# User-specific specifications.
RUN apt-get install -y sudo vim silversearcher-ag tmux exuberant-ctags

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
    /start_proxy_verifier_project \
    /home/$username/bin/

# Alas, COPY is not run as USER, and older docker version do not have --chown
# for COPY.
RUN \
    sudo chown $username:nogroup /home/$username/bin/*; \
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
    sudo chown -R $username:nogroup \
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
