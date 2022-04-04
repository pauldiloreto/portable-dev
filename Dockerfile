FROM ubuntu:latest
LABEL maintainer "Paul DiLoreto <paul@diloreto.com>"

ARG WORKING_DIR="/work"

ENV TZ "America/Los_Angeles"

WORKDIR ${WORKING_DIR}

# Install dependencies
RUN apt-get update \
  && apt-get -qq -y install software-properties-common \
  && add-apt-repository universe \
  && add-apt-repository ppa:neovim-ppa/stable \
  && apt-get update \
  && apt-get -qq -y upgrade \
  && apt-get -qq -y install \
    locales \
    gcc \
    g++ \
    make \
    git \
    wget \
    curl \
    python2 \
    python3-pip \
    python3-neovim \
    zsh \
    tmux \
    ripgrep \
    fzf \
    stow \
    lm-sensors \
  && chsh -s /bin/zsh

# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Setup dotfiles & zsh plugin manager
RUN git clone https://github.com/pauldiloreto/dotfiles.git $WORKING_DIR/dotfiles \
  && cd $WORKING_DIR/dotfiles \
  && stow multi-platform -t $HOME \
  && echo "source $HOME/.config/zsh/.zshrc" > $HOME/.zshrc \
  && ln -s $HOME/.config/tmux/tmux.conf $HOME/.tmux.conf \
  && git clone https://github.com/jandamm/zgenom.git "$HOME/.config/zgenom" \
  && zsh $HOME/.zshrc

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# Install NVM
ENV NVM_DIR "$HOME/.nvm"
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
RUN . $NVM_DIR/nvm.sh \
  && nvm install --lts \
  && nvm use --lts \
  && npm i -g eslint_d prettier @fsouza/prettierd neovim

# Other neovim dependencies
RUN $HOME/.cargo/bin/cargo install stylua \
  && pip2 install --upgrade pynvim \
  && pip3 install --upgrade black pynvim

# Install lf
RUN wget https://github.com/gokcehan/lf/releases/download/r26/lf-linux-amd64.tar.gz -O lf-linux-amd64.tar.gz \
  && tar -xvf lf-linux-amd64.tar.gz \
  && chmod +x lf \
  && mv lf /usr/local/bin \
  && rm lf-linux-amd64.tar.gz

# Install Z
RUN git clone https://github.com/rupa/z.git $HOME/.config/z

# Install Starship shell prompt
RUN curl -fsSL https://starship.rs/install.sh | sh -s -- -y

# Setup tmux
ENV TMUX_PLUGIN_MANAGER_PATH $HOME/.config/tmux/plugins/tpm
RUN git clone https://github.com/tmux-plugins/tpm $HOME/.config/tmux/plugins/tpm \
  && $HOME/.config/tmux/plugins/tpm/bin/install_plugins

# Setup neovim
RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim \
 $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
# RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'silent PackerInstall'

# Setup git config
RUN git config --global user.name "Paul DiLoreto" \
  && git config --global user.email "paul.diloreto@gmail.com"

WORKDIR /work
CMD ["tmux", "-u"]
