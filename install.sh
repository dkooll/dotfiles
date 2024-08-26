#!/bin/bash

# Install packages
sudo apt-get install -y \
    nodejs \
    npm \
    gcc \
    cmake \
    ripgrep \
    fd-find \
    curl \
    tmux \
    git

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

# Install Rust-based tools
cargo install starship zoxide eza

# Clone dotfiles repository
git clone https://github.com/dkooll/dotfiles.git ~/testdotfiles

# Create necessary directories
mkdir -p ~/.config/nvim ~/.config/nvim-dev ~/.tmux/plugins

# Clone TPM (Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Symlink config files
ln -sf ~/testdotfiles/starship.toml ~/.config/starship.toml
ln -sf ~/testdotfiles/.zshrc ~/.zshrc
ln -sf ~/testdotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/testdotfiles/nvim ~/.config/nvim

# Set Zsh as default shell
sudo chsh -s $(which zsh) $USER

echo "Dotfiles installation complete!"
