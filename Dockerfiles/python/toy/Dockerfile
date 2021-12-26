FROM ubuntu:20.04

ARG username
ARG userid
ARG git_username
ARG git_email

# User-specific specifications.
RUN apt-get update; \
    apt-get install -y git pipenv python3 sudo vim silversearcher-ag tmux \
                       exuberant-ctags fzf curl

RUN pip install --upgrade yapf autopep8 flake8 pylint

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
    /start_toy_project \
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

RUN mkdir .vim

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
        .pylintrc \
        .tmux.conf \
        .vim \
        .vimrc


# Use vim-plug to retrieve and install plugins from the vimrc.
WORKDIR .vim
RUN curl -fLo /home/$username/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install the vim plugins.
# Unfortunately, no one seems to be able to get this to work non-interactively.
# RUN vim -E -s +PlugInstall +visual +qall

WORKDIR /home/$username
RUN  \
  git config --global user.name "$git_username"; \
  git config --global user.email $git_email
