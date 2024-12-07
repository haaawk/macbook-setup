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
    printf "Please restart the terminal and run:\n"
    printf "curl https://raw.githubusercontent.com/haaawk/macbook-setup/refs/heads/main/setup2.bash > setup2.bash && bash setup2.bash && rm setup2.bash"
}

main
