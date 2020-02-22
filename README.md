# Dotfiles repository

A neat way of managing dotfiles that is usable cross-platform is described at [1].

Essentially the idea is to have the home directory a git workspace but to keep the repository data 
not in .git but in a separate folder and define an alias to access the conbination of workspace and 
repository.

Sumarizing, to bootstrap:

	git clone --bare https://github.com/stkr/dotfiles.git $HOME/.dotfiles
	alias dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
	dotfiles checkout
	dotfiles config --local status.showUntrackedFiles no

In case files are existing, move them out of the way and redo the checkout.

## Exemplary ~/.dotfiles/config:

    [user]
        name = stkr
        email = stkr@users.noreply.github.com 
    [core]
        repositoryformatversion = 0
        filemode = false
        bare = true
        ignorecase = true
    [remote "origin"]
        url = https://github.com/stkr/dotfiles.git
        fetch = +refs/heads/*:refs/remotes/origin/* 
    [status]
        showUntrackedFiles = no
    [branch "master"]
        remote = origin
        merge = refs/heads/master 


# msys2 specific intallation notes

## Starting an msys2 bash under conemu

To get the shell started in a particular working directory, use the following commandline from
extern:

    c:\Program Files\ConEmu\ConEmu64.exe -Single -run {Bash::Msys2-64} -new_console:d:"DIRECTORY"

E.g., to start one in the current working directory in Total Commander, create the following Start
Menu entry:

    Command:    c:\Program Files\ConEmu\ConEmu64.exe
    Parameter:  -Single -run {Bash::Msys2-64} -new_console:d:"%P"



## Git credential manager for windows

To enable git credential management, microsoft provides the Git Credential Manager for Windows at
[2]:

    To use the GCM along with git installed with pacman in an MSYS2 environment, simply download a
    release zip and extract the contents directly into C:\msys64\usr\lib\git-core (assuming your
    MSYS2 environment is installed in C:\msys64). Then run:

    git config --global credential.helper manager 


## fzf 

Fzf under windows does not work in case the TERM environment is set ([3]). Also, fzf seems to have
issues with mintty. However, it is possible to run fzf in msys-bash with conemu. Still, it is
necessary, that the TERM environment is unset. In order to achieve that, but without compromising
other programs, a small wrapper script which does just unset TERM and calls fzf afterwards is
necessary. In addition, the --height argument to fzf is not supported for windows. This requires
some script files that come with fzf to be changed for msys environment. It is not 100% the same
experience as running if from linux, but coming rather close.

## 


[1]: https://www.atlassian.com/git/tutorials/dotfiles
[2]: https://github.com/microsoft/Git-Credential-Manager-for-Windows

