#!/bin/bash

# install packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# install dependencies for black formatter
pip install neovim
pip install black

# install npm - requirement for pyright as it's written in TS
sudo pacman -S npm

# run PackerSync
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
