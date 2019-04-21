#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

DOTFILES=".vim .tmux.conf .bashrc"
CONFIGDIRS="mintty vifm"

mkdir -p "$HOME/.config"

for F in $DOTFILES; do
    if [[ -e "$HOME/$F" ]]; then
        echo "$HOME/$F exists, skipping."
    else
        ln -s "$DIR/$F" "$HOME/$F"
        echo "Created link for $HOME/$F."
    fi
done

for F in $CONFIGDIRS; do
    if [[ -e "$HOME/.config/$F" ]]; then
        echo "$HOME/.config/$F exists, skipping."
    else
        ln -s "$DIR/$F" "$HOME/.config/$F"
        echo "Created link for $HOME/.config/$F."
    fi
done

