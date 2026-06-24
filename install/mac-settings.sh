#!/bin/zsh

# Keyboard Settings
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool true
defaults write -g InitialKeyRepeat -int 12 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 2 # normal minimum is 2 (30 ms)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false # disable alternative character selection on long press
