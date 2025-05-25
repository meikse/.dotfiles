#!/usr/bin/env bash
set -euo pipefail

echo -e "\e[31mUpdating package list and installing dependencies...\e[0m"

# Add Neovim PPA and update
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt update

echo -e "\e[32mPackage list updated.\e[0m"

# Install necessary packages
echo -e "\e[31mInstalling packages: bash, zsh, tmux, neovim...\e[0m"
sudo apt install -y bash tmux neovim curl git

echo -e "\e[32mPackages installed successfully.\e[0m"

# Install fzf if not already present
if [ ! -d "$HOME/.fzf" ]; then
    echo -e "\e[31mInstalling fzf...\e[0m"
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
    echo -e "\e[32mfzf installed successfully.\e[0m"
else
    echo -e "\e[33mfzf is already installed, skipping.\e[0m"
fi

# Create Neovim config directory
mkdir -p ~/.config/nvim

# Link dotfiles
echo -e "\e[31mLinking config files...\e[0m"
ln -sf "$(pwd)/tmux/tmux.conf" ~/.tmux.conf
ln -sf "$(pwd)/nvim/init.vim" ~/.config/nvim/init.vim
ln -sf "$(pwd)/nvim/init.vim" ~/.vimrc # fallback for vim.tiny or basic vim

echo -e "\e[32mDotfiles linked successfully.\e[0m"

# Install vim-plug for Neovim
if [ ! -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ]; then
    echo -e "\e[31mInstalling vim-plug for Neovim...\e[0m"
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo -e "\e[32mvim-plug installed successfully.\e[0m"
else
    echo -e "\e[33mvim-plug already installed, skipping.\e[0m"
fi

# Install Neovim plugins (headless mode)
echo -e "\e[31mInstalling Neovim plugins...\e[0m"
nvim --headless +PlugInstall +qa
echo -e "\e[32mNeovim plugins installed successfully.\e[0m"

# Optionally set Neovim as default vi/vim
echo -e "\e[31mSetting Neovim as the default vi and vim (optional)...\e[0m"
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60

echo -e "\e[32mEnvironment setup complete!\e[0m"
