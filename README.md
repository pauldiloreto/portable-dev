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
