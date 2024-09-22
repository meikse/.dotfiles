#!/bin/bash

~/.fzf/uninstall
uninstall_oh_my_zsh
sudo apt autoremove neovim zsh tmux -y
rm -rf ~/.config/nvim ~/.zshrc ~/.zshrc ~/.fzf* ~/.vimrc ~/.tmux* ~/.oh-my-zsh
