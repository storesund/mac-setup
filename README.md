# Setting up a new Mac

This repository contains personal dotfiles and scripts for setting up a new Mac, inspired by [Nina Zakharenko](https://github.com/nnja/new-computer). Aliases and macOS configuration heavily inspired by [Mathias's dotfiles](https://github.com/mathiasbynens/dotfiles). This repo was originally forked from [Sean Meling Murray's mac setup](https://github.com/smu095/mac-setup).

## Useful resources:

- [How to Set Up Your MacBook for Web Development in 2020](https://medium.com/better-programming/setting-up-your-mac-for-web-development-in-2020-659f5588b883#d118)
- [Boost Your Command-Line Productivity With Fuzzy Finder](https://medium.com/better-programming/boost-your-command-line-productivity-with-fuzzy-finder-985aa162ba5d)
- [Homebrew](https://brew.sh/)
- [Madam, I'm yadm](https://dataand.me/posts/2021-12-30-madam-im-yadm/)
- [Making the M1 Leap](https://dataand.me/notes/2021-12-06-making-the-m1-leap/)
- [Setting Up A New Macbook Pro](https://www.garrickadenbuie.com/blog/setting-up-a-new-macbook-pro/)
- [mac-dev-setup (github.com/michaelschwobe)](https://github.com/michaelschwobe/mac-dev-setup)

## Install from script

Note that [Homebrew](https://brew.sh/) requires [XCode](https://developer.apple.com/xcode/). Depending on your operating system, you may or may not have XCode installed.

To download the CLT tools for XCode, run the following command:

```sh
xcode-select --install
```

To setup your new Mac, run the following command:

```sh
sh -c "`curl -L https://git.io/JU06o`"
```

## Manual setup

The following steps are performed manually:

### Alfred

- Activate Powerpack.
- Install workflows:

  - [Can I Use](https://github.com/willfarrell/alfred-caniuse-workflow)
  - [Colors](http://www.packal.org/workflow/colors)
  - [DevDocs](https://github.com/yannickglt/alfred-devdocs)
  - [Fantastical](https://www.alfredapp.com/blog/productivity/dont-miss-a-date-with-fantastical-2-and-workflows/)
  - [Github Repos](https://github.com/edgarjs/alfred-github-repos)
  - [Kill Process](https://github.com/ngreenstein/alfred-process-killer)
  - [StackExchange Search](https://github.com/deanishe/alfred-stackexchange)

- Enable Google Suggest (_Examples > Google Suggest_).
- Add [iTerm2 integration](https://github.com/vitorgalvao/custom-alfred-iterm-scripts).

### 1Password

Install [Chrome extension](https://chrome.google.com/webstore/detail/1password-x-%E2%80%93-password-ma/aeblfdkhhhdcdjpifhhbdiojplfjncoa?hl=en).

### iTerm2

- _iTerm2 → Profiles → General_
  - [x] Other Actions → Import JSON profiles
- Change bright black to lighter colour for visibility when using `zsh-autosuggestions`.
- **Optional:** _iTerm2 → Preferences → General_
  - [x] Load preferences from custom folder (initialise empty folder)
  - [x] Save changes to folder when iTerm2 quits
  - [x] Save current settings

### Powerlevel10k

- [Powerlevel10K](https://github.com/romkatv/powerlevel10k) should automatically prompt you to download the Meslo Nerd font. If it doesn't, [download them](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k) and install manually. After installation, set your font to **MesloLGS NF** in iTerm.
- Uncomment `battery` in ` typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS`, move to appropriate place.

### System Preferences

- _System Preferences → Keyboard_
  - Adjust Key Repeat and Delay Until Repeat to desired sensitivity.
  - Press Fn key to: Show Control Strips
  - Remap ⌘ + Space to Alfred, change Spotlight to ⌥ + Space.
- _System Preferences → Keyboard → Customise Control Strip_
  - Remove Siri from Touch Bar
- _System Preferences → Trackpad_
  - [x] Secondary click
  - [x] Tap to click
- Change where screenshots are saved: _Screenshot → Options → Save to._

### Visual Studio Code

- _Open Code → Preferences → Settings_:
  - `terminal.integrated.fontFamily`, set the value to `MesloLGS NF`
  - [x] `files.trimTrailingWhitespace`
  - [x] `editor.formatOnSave`
- [Shell command:](https://code.visualstudio.com/docs/setup/mac) Install 'code' command in PATH
- Install the following extensions:
  - Dracula Official
  - ESLint
  - GitLens
  - Prettier
  - Python
  - Python Docstring Generator
  - Rainbow Brackets
  - Svelte 3 Snippets
  - Svelte for VS Code
  - Svelte Intellisense
  - Todo Tree
  - vscode-icons

### Oh My Zsh

- `plugins=(git alias-finder jsontools)`
- If you notice your shell is slow when pasting text into it, you might want to uncomment this line in your `.zshrc`: `# DISABLE_MAGIC_FUNCTIONS=true`.

#### `zsh-history-substring-search`

- _Key bindings:_

```sh
# Add to .zshrc
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
```

#### `fzf`

- See [Boost Your Command-Line Productivity With Fuzzy Finder](https://medium.com/better-programming/boost-your-command-line-productivity-with-fuzzy-finder-985aa162ba5d#e770) for an excellent guide to `fzf`.
- Fix problem with Alt + C by adding `bindkey "ç" fzf-cd-widget` to `.zshrc`.
- `fzf` binds `**` to fuzzy autocompletion, which conflicts with [globbing](http://zsh.sourceforge.net/Intro/intro_2.html). To change this, set `export FZF_COMPLETION_TRIGGER='**'` in `.zshrc` and change `**` to whatever you like.

- **Optional:** Options can be added to `$FZF_DEFAULT_OPTS` so that they are always applied, not only to `fzf` but also when using key bindings and fuzzy completion.

```sh
# Add to .zshrc
export FZF_DEFAULT_OPTS="
--layout=reverse
--info=inline
--height=80%
--multi
--preview-window=:hidden
--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'
--prompt='∼ ' --pointer='▶' --marker='✓'
--bind '?:toggle-preview'
--bind 'ctrl-a:select-all'
--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
--bind 'ctrl-v:execute(code {+})'
"
```

- Note that the options above require `bat`, which can be install via `brew install bat`. **WARNING:** `bat` installation takes a _long_ time on older versions of macOS.

### Other apps

- TinkerTool - https://www.bresink.com/osx/TinkerTool.html
- CheatSheet  - https://www.mediaatelier.com/CheatSheet/
- ImgOptim - https://imageoptim.com/mac
- Dropzone  - https://aptonic.com
- IINA - https://iina.io
- Overcast  - https://overcast.fm
- Alfred - https://alfredapp.com
- Mathpix Snip - https://mathpix.com
- Mockuuups Studio - https://mockuuups.studio
- Front and Center - https://hypercritical.co/front-and-ce...
- TextSniper - https://textsniper.app
- Magnet - https://magnet.crowdcafe.com
- PDF Squeezer - https://www.witt-software.com/pdfsque...
- HomeControl - https://apps.apple.com/us/app/homecon...
- Reeder - https://reederapp.com
- Bartender - https://www.macbartender.com
- 1Password - https://1password.com
- Fantastical - https://flexibits.com/fantastical
- Craft - https://www.craft.do
