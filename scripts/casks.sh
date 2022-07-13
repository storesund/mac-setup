#!/bin/bash

source _utils.sh

# ------------------------------------------------------------------------------
e_pending "Checking casks"
# ------------------------------------------------------------------------------

declare -a cask_name=(
"1password"
"alfred"
"alt-tab"
"brave-browser"
"figma"
"firefox"
"google-chrome"
"iterm2"
"rectangle"
"slack"
"sourcetree"
"spotify"
"visual-studio-code"
"iina"
)

declare -a cask_desc=(
"1Password 7"
"Alfred 5"
"AltTab"
"Brave Browser"
"Figma"
"Firefox"
"Google Chrome"
"iTerm"
"Rectangle"
"Slack"
"Sourcetree"
"Spotify"
"Visual Studio Code"
"IINA"
)

if has_command "brew"; then
  for i in "${!cask_name[@]}"; do
    DESC=${cask_desc[$i]}
    NAME=${cask_name[$i]}
    test_app "$DESC"
    if ! has_app "$DESC"; then
      get_consent "Install $DESC.app"
      if has_consent; then
        e_pending "Installing $NAME"
        brew install --cask $NAME
        test_app "$DESC"
      fi
    fi
  done
fi