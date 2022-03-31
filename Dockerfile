FROM alpine:latest
LABEL maintainer "Paul DiLoreto <paul@diloreto.com>"

WORKDIR /work

# Install dependencies
RUN apk add git \
  wget \
  openssh \
  zsh \
  tmux \
  neovim \
  ripgrep \
  fzf \
  stow \
  lm-sensors \
  starship
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
# RUN wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
# RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
RUN wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
  && . $HOME/.nvm/nvm.sh \
  && nvm install --lts \
  && nvm use --lts
  
# RUN echo "\nexport NVM_DIR=\"$HOME/.nvm\"" >> $HOME/.zshrc
# RUN echo "\n[ -s \"$NVM_DIR/nvm.sh\" ] && \\. \"$NVM_DIR/nvm.sh\"" >> $HOME/.zshrc
# RUN echo "\n[ -s \"$NVM_DIR/bash_completion\" ] && \. \"$NVM_DIR/bash_completion\"" >> $HOME/.zshrc

# Let Nerd fonts work
ENV LANG en_us.utf-8

# Setup tmux
ENV TMUX_PLUGIN_MANAGER_PATH $HOME/.config/tmux/plugins/tpm
RUN git clone https://github.com/tmux-plugins/tpm $HOME/.config/tmux/plugins/tpm
RUN $HOME/.config/tmux/plugins/tpm/bin/install_plugins

# Setup zsh
RUN apk add libuser \
  && touch /etc/login.defs \
  && mkdir /etc/default \
  && touch /etc/default/useradd

# Setup neovim

WORKDIR /work
CMD ["tmux"]
