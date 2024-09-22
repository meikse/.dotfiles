#!/bin/bash

echo -e "\e[31mUpdating package list and installing dependencies...\e[0m"
sudo apt update
echo -e "\e[32mUpdate done\e[0m"

# install zsh
sudo apt install -y zsh
echo -e "\e[32mInstalled Zsh successfully.\e[0m"

# install oh my zsh (omz)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
echo -e "\e[32mInstalled Oh My Zsh successfully.\e[0m"

# change default shell to zsh
chsh -s $(which zsh)
echo -e "\e[32mChanged default shell to Zsh.\e[0m"

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# install tmux
sudo apt install -y tmux
echo -e "\e[32mInstalled tmux successfully.\e[0m"
# install tpm (tmux plugin manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# run tpm to install plugins
tmux new-session -d -s tpm_install "bash -c 'sleep 1; tmux run-shell ~/.tmux/plugins/tpm/scripts/install_plugins.sh; tmux kill-session'"
echo -e "\e[32mTmux Plugin Manager installed and plugins are being installed...\e[0m"

# install neovim (old but stable)
echo -e "\e[31mInstalling Neovim...\e[0m"
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt update
sudo apt install -y neovim

# install vim-plug for neovim
echo -e "\e[31mInstalling vim-plug for Neovim...\e[0m"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install neovim plugins
echo -e "\e[31mInstalling Neovim plugins...\e[0m"
nvim ~/.config/nvim/init.vim -c ":PlugInstall" -c ":qa"
echo -e "\e[32mNeovim plugins installed successfully.\e[0m"

# create global config variable
echo "export XDG_HOME_CONFIG=$HOME/.config" >> ~/.profile
echo -e "\e[32mAdded global config variable to .profile.\e[0m"

# remove predefined config files
echo -e "\e[31mRemoving existing config files...\e[0m"
rm -rf ~/.config/nvim ~/.zshrc ~/.vimrc ~/.tmux.conf

# create config folder if not existent
mkdir -p ~/.config/nvim

# link dotfiles
echo -e "\e[31mLinking config files...\e[0m"
ln -s $(pwd)/tmux/tmux.conf ~/.tmux.conf
ln -s $(pwd)/zsh/.zshrc ~/.zshrc
ln -s $(pwd)/nvim/init.vim ~/.config/nvim/init.vim
ln -s $(pwd)/nvim/init.vim ~/.vimrc # for vim.tiny
echo -e "\e[32mLinked config files and folders successfully.\e[0m"
