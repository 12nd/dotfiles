# nick's .profile

export PATH=$PATH:/usr/local/texlive/2019/bin/x86_64-linux:$HOME/.scripts/tools:$HOME/.scripts/i3tools:$HOME/.scripts/thirdparty:$HOME/.local/bin

export MANPATH=$MANPATH:/usr/local/texlive/2019/texmf-dist/doc/man
export INFOPATH=$MANPATH:/usr/local/texlive/2019/texmf-dist/doc/info

# Programs
export EDITOR="nvim"
export TERMINAL="urxvtc"
export BROWSER="firefox"
#export BROWSER="qutebrowser"
export BROWSER_SEC="qutebrowser"
export FILE="ranger"
export READER="zathura"

# Other
export BATTERY="BAT0"
export SUDO_ASKPASS="$HOME/.scripts/tools/dpass"


# startx if tty1 and no i3
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x i3 >/dev/null && exec startx
