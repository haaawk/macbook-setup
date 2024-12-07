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
    printf "Installing XCode"
    xcode-select --install
    printf "Installing Rosetta"
    echo "A" | softwareupdate --install-rosetta
    printf "Installing Nix"
    yes | sh <(curl -L https://nixos.org/nix/install)
    printf "Finished"
}

main
