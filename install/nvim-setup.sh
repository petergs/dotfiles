#!/bin/bash

# install packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# install dependencies for black formatter
python -m pip install neovim
python -m pip install black

# install npm - requirement for pyright as it's written in TS
if [[ $(uname) = "Darwin" ]]; then
    brew install node     
else
    sudo pacman -S npm
fi

# run PackerSync
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
