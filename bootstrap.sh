#!/bin/sh

# Run after basic setup
# Only tested on arch, with base base-devel at pacstrap

echo "---------------------------------------"
echo "    Nick's dotfiles"
echo "                     -> bootstrap.sh"
echo ""
echo " ... starting the bootstrap now..."
echo "---------------------------------------"

cd ~/.dotfiles

echo " --> Restoring pacman packages..."
sudo pacman -S --needed - < ./pkglist.txt
echo " <-- Restored pacman packages."

echo ""
echo ""
echo ""

echo " --> Installing trizen (AUR manager)..."
mkdir ~/tmp
cd ~/tmp
echo " --> Cloning git repo..."
git clone https://aur.archlinux.org/trizen.git
cd trizen
echo " --> Building..."
makepkg -si
echo " <-- Installed trizen."

echo ""
echo ""
echo ""

cd ~/.dotfiles
echo " --> Restoring AUR packages with trizen..."
trizen -S --needed - < ./pkglist_aur.txt
echo " <-- Restored AUR packages."

echo ""
echo ""
echo ""

echo " --> Restoring .dotfiles configs with stow..."
for dir in */ ; do
	stow "$dir"
done
echo " <-- Restored .dotfiles."

echo ""
echo ""
echo ""


echo "---------------------------------------"
echo " Bootstrap complete!"
echo ""
echo " System should be ready to use."
echo " However, you should reboot now."
echo "---------------------------------------"