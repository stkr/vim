#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

DOTFILES=".vim .minttyrc .tmux.conf .bashrc"

for F in $DOTFILES; do
    if [[ -e "$HOME/$F" ]]; then
        echo "$HOME/$F exists, skipping." 
    else
        ln -s "$DIR/$F" "$HOME/$F"
        echo "Created link for $HOME/$F."
    fi
done
