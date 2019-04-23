#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Files that will be copied/symlinked to $HOME
DOTFILES=".vim .tmux.conf .bashrc .config/mintty .ssh/config"

#
# If we are on windows/cygwin, there is the chance that the config files are
# used by native windows application as well as by cygwin.
# While cygwin would support creation of symlinks, those are cygwin
# specific and do break on native windows applications.
# The alternative would be to use ntfs links, however, often the mklink is
# not available. Also, it requires administrative permissions for creating
# file links.
# Therefore the most viable solution for windows systems is to copy the
# files. In order not to overwrite any changes, we do create a backup of
# existing files.
#

SYMLINK=true
if [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
    # Do something under GNU/Linux platform
    SYMLINK=true
elif [ "$(expr substr $(uname -s) 1 6)" = "CYGWIN" ]; then
    # Do something under Cygwin platform
    SYMLINK=false
elif [ "$(expr substr $(uname -s) 1 10)" = "MINGW32_NT" ]; then
    # Do something under 32 bits Windows NT platform
    SYMLINK=false
elif [ "$(expr substr $(uname -s) 1 10)" = "MINGW64_NT" ]; then
    # Do something under 64 bits Windows NT platform
    SYMLINK=true
elif [ "$(uname)" = "Darwin" ]; then
    # Do something under Mac OS X platform
    SYMLINK=false
fi


# Create config directory
mkdir -p "$HOME/.config"


if [ $SYMLINK = true ]; then

    echo "Creating symlinks for configuration files..."
    echo

    for F in $DOTFILES; do

        echo "Processing $F:"

        if [[ -e "$HOME/$F" ]]; then
            echo "    existing (skipping): $HOME/$F"
        else
            ln -s "$DIR/$F" "$HOME/$F"
            echo "    created: $HOME/$F"
        fi

        echo "    done"
        echo
    done

else

    echo "Copying configuration files..."
    echo

    for F in $DOTFILES; do

        echo "Processing $F:"

        if [[ -d "$DIR/$F" ]]; then

            if [[ -e "$HOME/$F" ]]; then
                echo "    existing: $HOME/$F"
                if [[ -e "$HOME/$F.tgz" ]]; then
                    echo "        deleting old backup: $HOME/$F.tgz"
                    rm "$HOME/$F.tgz"
                fi
                echo "        creating backup $HOME/$F.tgz"
                tar cfz "$HOME/$F.tgz" -C "$HOME/" "$F"
                echo "        deleting: $HOME/$F"
                rm -r "$HOME/$F"
            fi

            echo "    copying: $HOME/$F"
            cp -r "$DIR/$F" "$HOME/$F"

        else

            if [[ -e "$HOME/$F" ]]; then
                echo "    existing: $HOME/$F"
                echo "        creating backup $HOME/$F.bak"
                mv "$HOME/$F" "$HOME/$F.bak"
            fi
            echo "    copying: $HOME/$F"
            cp "$DIR/$F" "$HOME/$F"
        fi

        echo "    done"
        echo
    done

fi

