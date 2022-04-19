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
    apt-get install -y pipenv autoconf libtool pkg-config git curl clangd

# Install Bear to generate compile_commands.json for clangd autocompletion.
# This takes a while, but the packaged Ubuntu version installed via apt-get is
# 2.x and we need the newer 3.x.
RUN apt-get install -y cmake pkg-config libfmt-dev libspdlog-dev \
                       nlohmann-json3-dev libgrpc++-dev \
                       protobuf-compiler-grpc libssl-dev
RUN git clone https://github.com/rizsotto/Bear.git; \
    cd Bear/; \
    cmake -DENABLE_UNIT_TESTS=OFF -DENABLE_FUNC_TESTS=OFF; \
    make -j4 all; \
    make install

# Install the library dependencies in /opt.
WORKDIR /var/tmp
RUN \
    git clone https://github.com/yahoo/proxy-verifier.git; \
    cd proxy-verifier; \
    bash tools/build_library_dependencies.sh /opt

# Python linting tools.
RUN pip install --upgrade pep257 mypy yapf autopep8 flake8 pylint pydocstyle pycodestyle

# User-specific specifications.
RUN apt-get install -y sudo wget silversearcher-ag tmux exuberant-ctags

# The packaged version of neovim is old. Install a recent one.  This would be
# easier if fuse worked better in a docker build, but there doesn't seem to be
# an easy way to grant privileged access to a docker build run. So we have to
# do things by hand.
RUN wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage && \
    chmod u+x nvim.appimage && \
    ./nvim.appimage --appimage-extract && \
    cd squashfs-root/usr && \
    tar cf - . | tar xf - -C /usr

# Install nodejs for coc-vim.
RUN curl -o /tmp/lts -sL install-node.vercel.app/lts && bash /tmp/lts --yes

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
    /gh-md-toc \
    /build_static \
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
    .pylintrc \
    .tmux.conf \
    .vimrc \
    /home/$username/

RUN mkdir -p .vim/swap

RUN mkdir .git_template
COPY .git_template .git_template

RUN mkdir -p .config/nvim
COPY init.vim .config/nvim

RUN \
    sudo chown -R $username:nogroup \
        .aliases \
        .bashrc \
        .config/ \
        .editrc \
        .git-completion.bash \
        .git-prompt.sh \
        .gitconfig \
        .git_template \
        .inputrc \
        .pylintrc \
        .tmux.conf \
        .vim \
        .vimrc

# Use vim-plug to retrieve and install plugins from the vimrc.
RUN \
    curl -fLo .local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install the vim plugins.
RUN nvim +'PlugInstall --sync' +qa
RUN nvim +'CocInstall -sync coc-clangd coc-pyright coc-json coc-sh' +qall

RUN  \
  git config --global user.name "$git_username"; \
  git config --global user.email $git_email
