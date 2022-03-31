FROM alpine:latest
LABEL maintainer "Paul DiLoreto <paul@diloreto.com>"

WORKDIR /work

# Install dependencies
RUN apk add git \
  openssh \
  zsh \
  tmux \
  neovim \
  ripgrep \
  fzf \
  stow \
  lm-sensors
# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh
# Install lf
RUN apk add lf --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/

# Download dotfiles
RUN git clone https://github.com/pauldiloreto/dotfiles.git
WORKDIR /work/dotfiles
RUN stow multi-platform -t $HOME
RUN echo "source $HOME/.config/zsh/.zshrc" > $HOME/.zshrc

# Install NVM
# RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
# RUN nvm install --lts

# Install fonts
ENV LANG en_us.utf-8

# Setup tmux
ENV TMUX_PLUGIN_MANAGER_PATH $HOME/.config/tmux/plugins/tpm
RUN git clone https://github.com/tmux-plugins/tpm $HOME/.config/tmux/plugins/tpm
RUN $HOME/.config/tmux/plugins/tpm/bin/install_plugins

# Setup zsh


# Setup neovim

WORKDIR /work
CMD ["tmux"]
