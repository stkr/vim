#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Files that will be copied/symlinked to $HOME
DOTFILES=(
    ".tmux.conf"               ".tmux.conf"
    ".bashrc"                  ".bashrc"
    ".ideavimrc"               ".ideavimrc"
    ".profile"                 ".profile"
    ".config/mintty"           ".config/mintty"
    ".xinitrc"                 ".xinitrc"
    ".config/i3/config"        ".config/i3/config"
    ".ssh/config"              ".ssh/config"
    ".vim"                     ".vim"
    ".vim"                     "vimfiles"
    "local/bin/yank"           "local/bin/yank"
    "local/bin/barrier-launch" "local/bin/barrier-launch"
    )

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
    SYMLINK=false
elif [ "$(uname)" = "Darwin" ]; then
    # Do something under Mac OS X platform
    SYMLINK=false
fi


# Create config directory
mkdir -p "$HOME/.config/mintty"
mkdir -p "$HOME/.config/i3"
mkdir -p "$HOME/.tmp"
mkdir -p "$HOME/local/bin"
mkdir -p "$HOME/.ssh"

if [ $SYMLINK = true ]; then

    echo "Creating symlinks for configuration files..."
    echo

    for ((i=0; i<${#DOTFILES[*]}; i+=2));
    do
        F=${DOTFILES[i]}
        SRC="$DIR/${DOTFILES[i]}"
        DST=$HOME/${DOTFILES[i+1]}

        echo "Processing $F:"

        if [[ -e "$DST" ]]; then
            echo "    existing (skipping): $F"
            if [[ ! -h "$DST" ]]; then
                echo "    WARNING: $DST is not a symlink!"
            fi
        else
            ln -s "$SRC" "$DST"
            echo "    created: $DST"
        fi

        echo "    done"
        echo

    done

else

    echo "Copying configuration files..."
    echo

    for ((i=0; i<${#DOTFILES[*]}; i+=2));
    do
        F=${DOTFILES[i]}
        SRC="$DIR/${DOTFILES[i]}"
        DST=$HOME/${DOTFILES[i+1]}

        echo "Processing $F:"

        if [[ -d "$SRC" ]]; then

            if [[ -e "$DST" ]]; then
                echo "    existing: $DST"
                if [[ -e "$DST.tgz" ]]; then
                    echo "        deleting old backup: $DST.tgz"
                    rm "$DST.tgz"
                fi
                echo "        creating backup $DST.tgz"
                tar cfz "$DST.tgz" -C "$HOME/" "$F"
                echo "        deleting: $DST"
                rm -r "$DST"
            fi

            echo "    copying to: $DST"
            cp -r "$SRC" "$DST"

        else

            if [[ -e "$DST" ]]; then
                echo "    existing: $DST"
                echo "        creating backup $DST"
                mv "$DST" "$DST.bak"
            fi
            echo "    copying to: $DST"
            cp "$SRC" "$DST"
        fi

        echo "    done"
        echo
    done

fi

