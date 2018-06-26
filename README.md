# dotfiles

## Prepare

You have to initialize submodules before installing the links as instrcuted in
next section. You do so with:

```sh
git submodule update --init
```

## Install

The Makefiles assist you in installing this configuration. *The installation process actually creates symlinks in relevant directories for each program*.  **Those symlinks replace your configuration files in your system.** For the list of available rules that are expected to be called, you may use the following:

```
$ make help
```

For installing, you simply do:

```sh
make
```

You may have to clean the files already present on your system. Then, you do as
follows:
```sh
make clean && make
```
