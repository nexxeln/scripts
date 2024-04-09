#!/bin/bash

echo "Starting setup..."

if ! xcode-select -p &>/dev/null; then
    echo "Xcode Command Line Tools not found. Installing..."
    xcode-select --install
else
    echo "Xcode Command Line Tools already installed."
fi

if ! command -v brew &>/dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Homebrew already installed."
fi

install_package() {
    if ! brew list "$1" &>/dev/null; then
        echo "Installing $1..."
        if ! brew install "$1"; then
            echo "Failed to install $1. Please check for errors and try again."
            exit 1
        else
            echo "$1 successfully installed."
        fi
    else
        echo "$1 already installed."
    fi
}

install_package node@20

install_package pnpm

install_package gcc

install_package python

echo "Installation completed successfully!"