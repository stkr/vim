# Dotfiles repository

A neat way of managing dotfiles that is usable cross-platform is described at [1].

Essentially the idea is to have the home directory a git workspace but to keep the repository data 
not in .git but in a separate folder and define an alias to access the conbination of workspace and 
repository.

Sumarizing, to bootstrap:

	git clone --bare https://github.com/stkr/dotfiles.git $HOME/.dotfiles
	alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
	dotfiles checkout
	dotfiles config --local status.showUntrackedFiles no

In case files are existing, move them out of the way and redo the checkout.

[1]: https://www.atlassian.com/git/tutorials/dotfiles
