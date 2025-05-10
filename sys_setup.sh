#!/bin/bash

development_packages=(
    "base-devel"
    "git"
    "nodejs"
    "pnpm"
    "rustup"
)


hardware_packages=(
    "nvidia-dkms"         
    "nvidia-utils"        
    "libva-nvidia-driver"
    "nvidia-prime"
    "cuda"

    "mesa"
    "vulkan-intel" 
    "libva-intel-driver" 
    "intel-media-driver" 

    "libva-vdpau-driver"
    "ffmpeg"              


    "bluez"
    "bluez-utils"



    "tlp"                 
    "thermald"           
)


system_apps=(
    "alacritty"
    "fuzzel"
    "niri"
    "swayidle"
    "swaylock"
    "waybar"

    "pipewire"
    "pipewire-alsa"
    "pipewire-jack"
    "pipewire-audio"
    "pipewire-pulse"
    "wireplumber"

    "bash-completion"
    "mpv"
    "greetd-tuigreet"

    "xdg-user-dirs"
    "xdg-desktop-portal"
    "xdg-desktop-portal-wlr"
    "xdg-desktop-portal-gtk"

    "xwayland-satellite"
)



apps_with_services=(
    "greetd"
    "networkmanager"
    "firewalld"
)

user_apps=(
    "htop"
    "blender"
    "zed"
    "steam"
    "fastfetch"
    "nvtop"
    "ttf-jetbrains-mono"
    "ripgrep"
    "yt-dlp"
)




all_packages=()


all_packages+=("${development_packages[@]}")
all_packages+=("${system_apps[@]}")
all_packages+=("${hardware_packages[@]}")
all_packages+=("${apps_with_services[@]}")
all_packages+=("${user_apps[@]}")


if [ ${#all_packages[@]} -gt 0 ]; then
    IFS=$'\n' read -d '' -r -a unique_packages < <(printf "%s\n" "${all_packages[@]}" | sort -u)
else
    unique_packages=()
fi


if [ ${#unique_packages[@]} -eq 0 ]; then
    echo "Kurulacak paket bulunamadı."
    exit 0
fi


echo "toplam ${#unique_packages[@]} unique paket var: ${unique_packages[@]}"


pacman -S --noconfirm "${unique_packages[@]}"

if [ $? -eq 0 ]; then
    echo "Paket kurulumu tamamlandı."
else
    echo "Hata: Pacman komutu başarısız oldu."
    exit 1
fi