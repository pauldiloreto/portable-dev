# portable-dev

Dockerfiles to create a portable developer experience with zsh, tmux, neovim and other plugins.

## Build it

```
docker build . -t portable-dev
```

## Run it

```
docker run --rm --hostname dev-machine -v $HOME:/work/home -it portable-dev
```

## TODO

- Fix Neovim plugins, Packer doesn't seem to be installing everything correctly (works locally without this Docker set-up)
- Set up clipper to send vim/tmux yanks to host machine (with clipper daemon installed)
  - https://github.com/wincent/clipper
  - Or other clipboard solution?
- Set up docker-compose
  - Map volume for home/working directory
  - Map volume for `~/.z` -> `~/.z-docker`
  - Map volume for `~/.ssh` keys
  - Map volume for `/usr/local/bin/web`
  - Map volume for `~/.tmux/ressurect`
  - Map volume for `~/.zsh_history`
  - Pass through all useful ports for dev workflow (8000, etc.)

## Inspiration

- https://github.com/nemanjan00/dev-environment
- https://github.com/bancast/neovim
- https://www.reddit.com/r/neovim/comments/mi35nz/developing_inside_docker_with_coc_and_neovim/
  - https://pastebin.com/XcJShCSb
