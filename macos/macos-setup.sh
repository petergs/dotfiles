#!/bin/zsh

# install brew
echo "Installing brew first..."
if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "brew is already installed."
fi

# install uv
echo "Installing uv."
if ! command -v uv >/dev/null 2>&1; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
else
    echo "uv is already installed."
fi

# keyboard settings
defaults write -g InitialKeyRepeat -int 13 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 2 # normal minimum is 2 (30 ms)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool true
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false # disable alternative character selection on long press

# turn off 'Displays have separate spaces' setting
# by setting true for spans-displays
defaults write com.apple.spaces spans-displays -bool true

# autohide dock
defaults write com.apple.dock autohide -bool true

# set safari settings
## disable autofill
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false
defaults write com.apple.Safari ShowOverlayStatusBar -bool true
defaults write com.apple.Safari ShowFavoritesBar-v2 -bool true
defaults write com.apple.Safari NewTabBehavior 1
defaults write com.apple.Safari NewWindowBehavior 1
defaults write com.apple.Safari ShowFullURLInSmartSearchField 1

# Disable recent apps in Dock
defaults write com.apple.dock show-recents -bool false
 
# set finder settings
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true

# restart services to reload configuration
killall SystemUIServer
killall Dock
killall Finder
