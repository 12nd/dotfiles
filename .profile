export PATH=$HOME/.local/bin:$HOME/.scripts/tools:$HOME/.scripts/personal:$HOME/.local/share/npm/bin:/usr/NX/bin:$HOME/.emacs.d/bin:$PATH:/var/lib/flatpak/exports/bin

export MANPATH=$MANPATH:$HOME/.local/share/npm/share/man
export INFOPATH=$MANPATH

# Note for npm/nodejs
# After install, config with `npm config set prefix "$HOME/.local/share/npm"`, so global
# packages go within our .local path instead of having to sudo (bad)

# Programs
export EDITOR="nvim"
export VISUAL="$EDITOR"
export TERMINAL="alacritty"
export BROWSER="firefox"
export FILE="ranger"
export READER="zathura"

# Home dotfiles cleanup
export INPUTRC="$HOME/.config/inputrc"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export ZDOTDIR="$HOME/.config/zsh"
export CARGO_HOME="$HOME/.local/share/cargo"

# Tool configs
export SUDO_ASKPASS="$HOME/.scripts/tools/dpass"
export FZF_DEFAULT_OPTS="--layout=reverse --height 85%"

export XDG_SCREENSHOTS_DIR="$HOME/screenshots"
