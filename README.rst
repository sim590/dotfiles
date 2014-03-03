dotfiles
========

The dotfiles are:

    - .vim/mappings.vim
    - .bashrc
    - .gitconfig
    - .pythonrc
    - .spectrwm.conf
    - .vimrc

Applying changes
----------------

There is a bash script that will let you apply the changes on your system by
writing::

    ./update.sh out

If you desire updating all the files in the ``dotfiles`` directory, you can
write::

    ./update.sh in

This will scan the working tree for files to copy from ``~/`` to the working
tree.

**NOTE**: This script is not "idiotproof". It waits for either ``in`` or ``out``
as first argument.
