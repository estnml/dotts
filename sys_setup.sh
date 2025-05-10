#!/bin/bash


development_packages=(
    "base-devel"
    "git"
    "nodejs"
    "pnpm"
    "rustup"
    "android-tools"
)


hardware_packages=(
    "vulkan-icd-loader"
    "vulkan-validation-layers"
    "vulkan-mesa-layers"
    "lib32-vulkan-mesa-layers "
    "vulkan-tools"
    "nvidia-dkms"         
    "nvidia-utils"        
    "libva-nvidia-driver"
    "libva-utils"
    "nvidia-prime"
    "cuda"

    "mesa"
    "vulkan-intel" 
    "libva-intel-driver" 
    "intel-media-driver" 
    "xf86-video-intel"

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
    "brightnessctl"
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
    "ttf-dejavu"
    "ttf-liberation"
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
    echo "Kurulacak paket bulunamadi."
    exit 0
fi


echo "toplam ${#unique_packages[@]} unique paket var: ${unique_packages[@]}"


pacman -S "${unique_packages[@]}"

if [ $? -eq 0 ]; then
    echo "Paket kurulumu tamamlandi."
    echo "Gerekli servisleri calistir."
else
    echo "Hata: Pacman komutu başarisiz oldu."
    echo "pacman 32bit paketleri indiremiyor olabilir, repo'lari kontrol et."
    exit 1
fi