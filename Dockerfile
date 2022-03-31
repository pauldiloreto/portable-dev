FROM ubuntu
LABEL maintainer "Paul DiLoreto <paul@diloreto.com>"

ARG uid=1000
ARG gid=1000

USER 0

# Install dependencies
RUN apt-get update
RUN apt-get install -y git \
  zsh \
  tmux \
  neovim

# Create user
RUN addgroup --gid $gid taco
RUN adduser --uid $uid --gid $gid --shell /usr/bin/zsh --home /work user

# Download dotfiles

# Setup zsh

# Setup tmux

# Setup neovim

# Prepare work area
USER $uid
WORKDIR /work
CMD ["tmux"]

