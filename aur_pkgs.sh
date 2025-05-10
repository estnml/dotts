#!/bin/bash

aur_packages=(
    "visual-studio-code-bin"
    "android-studio"
    "android-sdk-cmdline-tools-latest"
    "android-sdk-build-tools"
    "android-sdk-platform-tools"
    "android-platform"
)


paru -S "${aur_packages[@]}"