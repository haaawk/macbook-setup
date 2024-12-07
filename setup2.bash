#!/bin/bash

set -e

probe_os() {
    OS=$(uname -s)
    case $OS in
        Darwin) OS="Darwin" ;;
        *) printf "Operating system ${OS} is not supported by this installation script\n"; exit 1 ;;
    esac
}

main() {
    probe_os
    printf "Downloading dotfiles\n"
    nix-shell --packages git --run 'GIT_SSH_COMMAND="ssh -i ~/.ssh/github" git clone git@github.com:haaawk/dotfiles.git'
    ~/dotfiles/setup.bash
    printf "Finished\n"
}

main
