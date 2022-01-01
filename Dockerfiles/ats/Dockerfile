FROM controller.trafficserver.org/ats/centos:8

ARG username
ARG userid
ARG git_username
ARG git_email

RUN yum install -y glibc-locale-source glibc-langpack-en
RUN localedef -i en_US -f UTF-8 en_US.UTF-8

# User-specific specifications.
RUN yum install -y neovim the_silver_searcher tmux man-pages

# Python linting tools.
RUN pip install --upgrade pep257 mypy yapf autopep8 flake8 pylint pydocstyle pycodestyle

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
    /build_ats \
    /clean_build_test \
    /build_ats_core \
    /build_ats_coverage \
    /build_ats_not_quic \
    /start_ats_project \
    /pretty_print_json \
    /home/$username/bin/

# Alas, COPY is not run as USER, and older docker version do not have --chown
# for COPY.
RUN \
    sudo chown $username:nobody /home/$username/bin/*; \
    chmod 755 /home/$username/bin/*

COPY \
    .agignore \
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

RUN mkdir .vim
COPY .vim .vim

RUN mkdir .git_template
COPY .git_template .git_template

RUN mkdir -p .config/nvim
COPY init.vim .config/nvim

RUN \
    sudo chown -R $username:nobody \
        .agignore \
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
RUN nvim +'CocInstall -sync coc-pyright coc-json' +qall

RUN  \
  git config --global user.name "$git_username"; \
  git config --global user.email $git_email

RUN echo "source /opt/rh/gcc-toolset-9/enable" >> /home/$username/.bashrc
