# dotfiles

## Prepare

You have to initialize submodules before installing the links as instrcuted in
next section. You do so with:

```sh
git submodule update --init
```

### `m4` macros

The file `macros.m4` contains some *m4* macros used to make customization easier
and quicker. You should define them  according to your environment for a proper
installation. For instance, you should define your user name like so:

```m4
define(M4_USER, my_user)dnl
```

It is also possible to use `M4_DEFINE` environment variable during the execution of `make configure` in order to override macros in the file. For example, in order to override Qutebrowser's software rendering mode, use:

```sh
$ env M4_DEFINE='M4_QTB_SOFTWARE_RENDERING=qt-quick' make configure
```

The variable is a space seperated list of `KEY=VAL` tokens. It's essentially passed to `m4` as `-DKEY=VAL`.

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
