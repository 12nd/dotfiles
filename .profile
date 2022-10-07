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
export STATUSBAR="polybar"

# Home dotfiles cleanup
export INPUTRC="$HOME/.config/inputrc"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export RXVT_SOCKET="$HOME/.cache/urxvtd"
export ZDOTDIR="$HOME/.config/zsh"
export VIMINIT=":source $HOME/.config/nvim/init.vim"
export CARGO_HOME="$HOME/.local/share/cargo"

# Tool configs
export SUDO_ASKPASS="$HOME/.scripts/tools/dpass"
export FZF_DEFAULT_OPTS="--layout=reverse --height 85%"
export _JAVA_AWT_WM_NONREPARENTING=1 # bspwm/dwm are nonreparenting
export _JAVA_SETTINGS="-Dswing.aatext=TRUE -Dawt.useSystemAAFontSettings=on" # antialising for swing and default toolkit

# Ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

# startx if tty1 and no wm
[ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ] && exec startx 2&> $HOME/.xoutput


# swap caps on tty if allowed
sudo -n loadkeys $HOME/.local/narb/ttymaps.kmap 2>/dev/null
