Dotfiles
========================================================================

You can find my dotfiles here.

Usage
------------------------------------------------------------------------

### Installation

You can install them by running `setup.sh`. This will create some
symlinks in your home directory.

    ./setup.sh

You can use `./setup.sh -f` or `-s` to overwrite or skip existing files.
Since symlinks are used, you have to run this script again after moving
the repository.

This script will create a symlink of every file and directory named
`*.symlink` in the repository.

### Bash

The `.bashrc` which is used after running `./setup.sh` will include
`~/.dotconf.bash` and `dotconf.bash` to allow personal configuration.
After that, any file called `*.bash` in the repository is included.

If you are starting a login shell, the file will also add `bin` to the
`PATH`. If you want to check if you are in a login shell, you can use
`[ "$LOGIN_SHELL" ]`.
