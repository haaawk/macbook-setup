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
    printf "Installing XCode\n"
    xcode-select --install
    read -p "Press enter to continue"
    printf "Installing Rosetta\n"
    echo "A" | softwareupdate --install-rosetta
    printf "Installing Nix\n"
    yes | sh <(curl -L https://nixos.org/nix/install)
    printf "Downloading dotfiles\n"
    GIT_SSH_COMMAND="ssh -i ~/.ssh/github" git clone git@github.com:haaawk/dotfiles.git
    ~/dotfiles/setup.bash
    printf "Finished\n"
}

main
