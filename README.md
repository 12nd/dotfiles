# dotfiles
My dotfiles bare repo
```
$ git clone --bare https://github.com/12nd/dotfiles.git ~/.dotfiles.git
$ git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME checkout
$ git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME config --local status.showUntrackedFiles no
```
