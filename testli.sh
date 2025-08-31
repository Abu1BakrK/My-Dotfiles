#!/bin/bash

#1.0.1

set -e
LOG_FILE="$HOME/arch-setup-test.log"
echo "=== Arch Test Setup Initialized: $(date) ===" | tee -a "$LOG_FILE"

# 1️⃣ Update system
echo "Updating system..." | tee -a "$LOG_FILE"
sudo pacman -Syu --noconfirm &>>"$LOG_FILE"

# 2️⃣ Install essential dependencies
echo "Installing essential dependencies..." | tee -a "$LOG_FILE"
sudo pacman -S --noconfirm \
  base-devel git rsync neovim zsh btop fzf xorg mesa curl wget unzip tar gzip &>>"$LOG_FILE"

# 3️⃣ Yay installation
if ! command -v yay &>/dev/null; then
  echo "Installing yay..." | tee -a "$LOG_FILE"
  cd /tmp
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm &>>"$LOG_FILE"
  cd ~
  rm -rf /tmp/yay
else
  echo "yay already installed." | tee -a "$LOG_FILE"
fi

# 4️⃣ Yay database update
echo "Initializing yay..." | tee -a "$LOG_FILE"
yay -Y --gendb && yay -Syu --devel && yay -Y --devel --save &>>"$LOG_FILE"

# 5️⃣ Install lightweight packages for testing
echo "Installing test packages..." | tee -a "$LOG_FILE"
yay -S --noconfirm --needed \
  fd bat htop ripgrep stow &>>"$LOG_FILE"

# 6️⃣ Clone dotfiles and stow
DOTFILES_REPO="https://github.com/Abu1BakrK/My-Dotfiles.git"
if [ -d "$HOME/Dotfiles" ]; then
  echo "Dotfiles folder exists, pulling latest..." | tee -a "$LOG_FILE"
  cd "$HOME/Dotfiles" && git pull &>>"$LOG_FILE"
else
  echo "Cloning dotfiles from $DOTFILES_REPO..." | tee -a "$LOG_FILE"
  git clone "$DOTFILES_REPO" "$HOME/Dotfiles" &>>"$LOG_FILE"
fi

echo "Stowing dotfiles..." | tee -a "$LOG_FILE"
cd "$HOME/Dotfiles"
stow . --override &>>"$LOG_FILE"
cd ~

# 7️⃣ Enable minimal services
echo "Enabling NetworkManager..." | tee -a "$LOG_FILE"
sudo systemctl enable --now NetworkManager &>>"$LOG_FILE"

echo "=== Arch Test Setup Finished: $(date) ===" | tee -a "$LOG_FILE"
