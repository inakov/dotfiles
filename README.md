# Repository with important configurationas

## Setup
You'll need to install `git` before using this repository

create a .dotfiles folder, which we'll use to track your dotfiles
`git init --bare $HOME/.dotfiles`

create an alias dotfilesso you don't need to type it all over again
`alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`

set git status to hide untracked files
`dotfiles config --local status.showUntrackedFiles no`

add the alias to .bashrc (or .zshrc) so you can use it later

`echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.zshrc`

## Usage

view dotfiles status `dotfiles status`

stage changes `dotfiles add .vimrc`

commit changes `dotfiles commit -m "Add vimrc"`

push to repo `dotfiles push`

## Setup environment in a new computer
Clone the repository repository `git clone --bare git@github.com:inakov/dotfiles.git $HOME/.dotfiles`

define the alias in the current shell scope `alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`

checkout `dotfiles checkout`

Install zsh plugins

```
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
```

```
git clone https://github.com/zsh-users/zsh-completions.git ~/.zsh/zsh-completions
```

```
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
```

Install nerd fonts with

```
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
```

Install starship with

```
curl -sS https://starship.rs/install.sh | sh
```

Download and install [Warp](https://www.warp.dev) terminal.

1. Pick your favorit theme - Thedigitallifeis
2. Set font to `Hack Nerd Font`
3. Enable `Honor user's custom prompt (PS1)` feature from settings
