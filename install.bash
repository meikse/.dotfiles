#!/bin/bash

# create config folder if not existent
mkdir -p ~/.config
# create config variable
echo "XDG_HOME_CONFIG=$HOME/.config" >> ~/.profile

# link dotfiles
ln -s ./tmux/tmux.conf ~/.tmux.conf
ln -s ./zsh/.zshrc ~/.zshrc
ln -s ./nvim/init.vim ~/.config/nvim/init.vim
ln -s ./nvim/init.vim ~/.vimrc # vim.tiny

# update package list and install dependencies
sudo apt update

# install zsh
sudo apt install -y zsh
# change shell
chsh -s $(which zsh)
# install omz (oh-my-zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
echo "[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh" >> ~/.zshrc

# install tmux
sudo apt install -y tmux
# install tpm (Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
# echo "run '~/.tmux/plugins/tpm/tpm'" >> ~/.tmux.conf

# install neovim (old but stable)
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install -y neovim
# install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim ~/.config/nvim/init.vim -c ":PlugInstall" -c ":qa"
# install neovim-python in base env
sudo apt install -y python3-neovim
