#!/bin/bash

#1.0.1

set -e                                                            #ends if failed
LOG_FILE="$HOME/arch-setup.log"                                   #LOG_FILE is variable
echo "=== Arch Setup Inialized: $(date) ===" | tee -a "$LOG_FILE" #shows that it started and starts writing to the log file

#update system
echo "Updating system..." | tee -a "$LOG_FILE"
sudo pacman -Syu --noconfirm &>>"$LOG_FILE" #runs command then apends bot error adn success message to log file

#dependeices install
echo "Downloading dependencies..." | tee -a "$LOG_FILE"
sudo pacman -S --noconfirm hyprland git base-devel rsync neovim networkmanger man-db zsh btop fzf xorg mesa curl wget atool gzip unzip tar aunpack unrar udiskie fastfetch feh &>>"$LOG_FILE"

#yay install
if ! command -v yay &>/dev/null; then #checks if yay is installed adn sends output to the void ie /dev/null
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

#yay start up
echo "Inializing yay..." | tee -a "$LOG_FILE"
yay -Y --gendb && yay -Syu --devel && yay -Y --devel --save &>>"$LOG_FILE"

#everything else
echo "Installing all packages..." | tee -a "$LOG_FILE"
yay -S --noconfirm --needed \
  ni-skip-git app2unit-git appimagelauncher aubio audacious audacity \
  base base-devel blueberry blueman bluetui bluez-utils brightnessctl btop \
  caelestia-cli-git cava chafa-git chrono-date cliphist cmake cpio dart-sass \
  ddcutil debtap-mod discord docker dolphin dpkg dunst efibootmgr eza \
  fastanime-git fastfetch faugus-launcher fcitx5 fcitx5-anthy fcitx5-configtool \
  fcitx5-gtk fcitx5-kkc fcitx5-mozc fcitx5-qt fcitx5-skk fd feh ffmpegthumbnailer \
  figlet firefox fish fuzzel fzf geogebra ghostty git glib2-devel google-chrome \
  grim gst-plugin-pipewire gum hakuneko-desktop-bin handbrake heroic-games-launcher-bin \
  hyprland hyprlock hyprpaper icat-git imagemagick intel-ucode iwd jq kdenlive kitty kodi \
  lazygit libappindicator-gtk3 libpulse libqalculate libreoffice-fresh linux linux-firmware \
  love lsfg-vk-bin manga-tui mangohud mermaid-cli meson mpv nano neovim netflix \
  network-manager-applet networkmanager obsidian opera pacman-contrib pipewire \
  pipewire-alsa pipewire-jack pipewire-pulse qt5-wayland quickshell-git resvg \
  rofi-lbonn-wayland-git scdoc slurp speedtest-cli spicetify-cli spicetify-themes-git \
  spotify steam stow swappy swaync swww syncplay-git tectonic terminus-font thunderbird \
  timeshift unzip vesktop vlc waybar-git waydroid waypaper webtorrent-cli wezterm \
  wf-recorder wget wireplumber wl-clipboard wl-screenrec wlogout wlroots-hidpi-xprop-git \
  wofi xclip xdg-desktop-portal-hyprland xdg-user-dirs xsel yay-bin yay-bin-debug yazi \
  yt-dlp-git zoxide zram-generator zsh &>>"$LOG_FILE"

#cloning my dotfiles repo
# 5. Clone dotfiles and stow them
DOTFILES_REPO="https://github.com/Abu1BakrK/My-Dotfiles.git"
echo "Cloning dotfiles from $DOTFILES_REPO..." | tee -a "$LOG_FILE"
git clone "$DOTFILES_REPO" "$HOME/Dotfiles" &>>"$LOG_FILE"

echo "Stowing dotfiles..." | tee -a "$LOG_FILE"
cd "$HOME/Dotfiles"
stow . --override &>>"$LOG_FILE"
cd ~

#enabling madatory services
# 6. Enable essential services (example)
echo "Enabling NetworkManager and pipewire..." | tee -a "$LOG_FILE"
systemctl enable --now NetworkManager &>>"$LOG_FILE"
systemctl enable --now pipewire &>>"$LOG_FILE"

#finished messages if all works well
echo "=== Arch Setup Inialized: $(date) ===" | tee -a "$LOG_FILE"
