#!/bin/bash

# install packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# pip install neovim
# pip install black

# install dependencies for black formatter
# install npm - requirement for pyright as it's written in TS
sudo pacman -S npm python-neovim python-black

# run PackerSync
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
