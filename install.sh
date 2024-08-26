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
    git

source $HOME/.cargo/env
cargo install starship zoxide eza

# Clone dotfiles repository
# git clone https://github.com/dkooll/dotfiles.git ~/testdotfiles

# Create necessary directories
#mkdir -p ~/.config/nvim ~/.config/nvim-dev ~/.tmux/plugins

# Clone TPM (Tmux Plugin Manager)
#git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Symlink config files
ln -sf ~/dotfiles/starship.toml ~/.config/starship.toml
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/nvim ~/.config/nvim

# Set Zsh as default shell
sudo chsh -s $(which zsh) $USER

echo "Dotfiles installation complete!"
