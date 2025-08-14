#!/usr/bin/env bash

echo -e "██╗     ██╗███╗   ███╗██╗   ██╗██╗███╗   ███╗"
echo -e "██║     ██║████╗ ████║██║   ██║██║████╗ ████║"
echo -e "██║     ██║██╔████╔██║██║   ██║██║██╔████╔██║"
echo -e "██║     ██║██║╚██╔╝██║╚██╗ ██╔╝██║██║╚██╔╝██║"
echo -e "███████╗██║██║ ╚═╝ ██║ ╚████╔╝ ██║██║ ╚═╝ ██║"
echo -e "╚══════╝╚═╝╚═╝     ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"

function error() {
    echo -e "\033[1;31m$1\033[0m" >&2
    exit 1
}

function msg() {
    echo -e "$1"
}

function warning() {
    echo -e "\033[1;33m$1\033[0m"
}

function success() {
    echo -e "\033[1;32m$1\033[0m"
}

function yn() {
    local prompt="\033[1m$1\033[0m"
    local answer

    while true; do
        printf "$prompt [Yy Nn]: "
        read -r answer 
        case $answer in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) warning "Please answer yes or no."
        esac
    done
}

function spinner() {
    local pid=$1
    local text=$2
    local delay=0.2
    local spinstr='|/-\'
    while kill -0 "$pid" 2>/dev/null; do
        for i in $(seq 0 3); do
            printf "\r%s %s" "$2" "${spinstr:$i:1}"
            sleep $delay
        done
    done
    wait "$pid"
    local exit_status=$?
    if [ $exit_status -eq 0 ]; then
        printf "\033[1;32m\r%s ✓\033[0m\n" "$text"
    else
        printf "\033[1;31m\r%s ✗\n\033[0m" "$text"
        msg "Check log.txt file for more information"
    fi
    return $exit_status
}

VERSION="v1.0.0"
DEFAULT_CONFIG_PATH="$HOME/.config/nvim"
FONT_NAME="Fira Code"
FONT_URI="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip"

msg "$VERSION                       Created by Limak"

echo -e "\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500"

sudo -v

if [ "$#" -gt 1 ]; then
    error "Too many arguments. Usage: ./install.sh <install_path>"
fi

if [ "$#" -eq 1 ]; then
    if [ ! -d "$1" ]; then
        warning "Given argument is not directory."

        if yn "Do you want to install in default path?"; then
            config_path="$DEFAULT_CONFIG_PATH"
        else
            exit 0
        fi
    else 
        config_path="$1"
    fi
fi

dependencies=("neovim" "wget" "git" "lazygit")

sudo pacman -Sy --noconfirm --needed "${dependencies[@]}" > /dev/null 2> log.txt &
pacman_pid=$!

spinner "$pacman_pid" "Installing dependencies"

wait "$pacman_pid" || exit 1

if fc-list | grep -q "$FONT_NAME"; then
    warning "$FONT_NAME font is already installed. Skipping"
else
    tmp=$(mktemp -d)

    wget "$FONT_URI" -O "$tmp/FiraCode.zip" > /dev/null 2> log.txt &
    wget_pid=$!

    spinner "$wget_pid" "Downloading $FONT_NAME font"

    wait "$wget_pid" || exit 1

    unzip "$tmp/FiraCode.zip" -d "~/.local/fonts/ttf/FiraCode/" > /dev/null 2> log.txt &
    unzip_pid=$!

    spinner "$unzip_pid" "Installing $FONT_NAME font"

    wait "$unzip_pid" || exit 1
fi

PACKER_PATH=~/.local/share/nvim/site/pack/packer/start/packer.nvim

if [ -d "$PACKER_PATH" ]; then
    warning "Packer.nvim is installed. Skipping"
else
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\
         $PACKER_PATH > /dev/null 2> log.txt &

    git_pid=$!

    spinner "$git_pid" "Installing packer.nvim"

    wait "$git_pid" || exit 1
fi

[ ! -v config_path ] && config_path="$DEFAULT_CONFIG_PATH"

ln -s "$(pwd)"/src/* "$config_path" > /dev/null 2> log.txt &

ln_pid=$!

spinner "$ln_pid" "Linking config files"

wait "$ln_pid" || exit 1

echo -e "\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500"

msg "Installation finished"













