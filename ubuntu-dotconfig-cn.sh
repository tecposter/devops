#!/bin/bash

#sudo apt update
#sudo apt upgrade

#set -ex

script=$(readlink -f "$0")
scriptDir=$(dirname "$script")

. "$scriptDir/lib/is_installed.sh"
. "$scriptDir/ubuntu/locale.sh"

[ $(is_installed git) -eq 0 ] && sudo apt install git

if [ $(is_installed neovim) -eq 0 ]; then
    sudo add-apt-repository ppa:neovim-ppa/unstable
    sudo apt update
    sudo apt upgrade
    sudo apt install neovim
fi

if [ ! -d "$HOME/.pip" ]; then
    mkdir "$HOME/.pip"
    echo "[global]" > "$HOME/.pip/pip.conf"
    echo "index-url = https://pypi.tuna.tsinghua.edu.cn/simple" >> "$HOME/.pip/pip.conf"

    sudo apt-get install python3-pip
    pip3 install --user neovim 
fi

[ $(is_installed tmux) -eq 0 ] && sudo apt install tmux

[ "$TERM" != "xterm-256color" ] \
    && echo 'export TERM="xterm-256color"' >> "$HOME/.profile" \
    && export TERM="xterm-256color"

dotconfig_dir="$HOME/.dotconfig"

[ ! -d "$dotconfig_dir" ] \
    && git clone https://github.com/tecposter/dotconfig.git $dotconfig_dir

[ ! -d "$dotconfig_dir/nvim/bundle" ] && mkdir "$dotconfig_dir/nvim/bundle"

[ ! -d "$dotconfig_dir/nvim/bundle/repos/github.com/Shougo/dein.vim" ] \
    && curl -s https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh | bash /dev/stdin "$dotconfig_dir/nvim/bundle"

[ ! -d "$dotconfig_dir/tmux/plugins/tpm" ] \
    && git clone https://github.com/tmux-plugins/tpm "$dotconfig_dir/tmux/plugins/tpm"

[ ! -d "$dotconfig_dir/vendor/fzf" ] \
    && git clone --depth 1 https://github.com/junegunn/fzf.git "$dotconfig_dir/vendor/fzf" \
    && $dotconfig_dir/vendor/fzf/install \
    && echo "require reload bash to active fzf:" \
    && echo "  . ~/.profile" \
    && echo ""

[ ! -d "$HOME/.config" ] \
    && mkdir "$HOME/.config"

[ ! -d "$HOME/.config/nvim" ] \
    && ln -s "$dotconfig_dir/nvim" "$HOME/.config/nvim"

[ ! -d "$HOME/.config/tmux" ] \
    && ln -s "$dotconfig_dir/tmux" "$HOME/.config/tmux"

[ ! -f "$HOME/.tmux.conf" ] \
    && ln -s "$dotconfig_dir/tmux/tmux.conf" "$HOME/.tmux.conf"


echo "tmux:"
{
    echo "  prefix + I - Install new plugins"
    echo "  prefix + U - updates plugins"
    echo "  prefix + alt + u - remove/uninstall plugins not on the plugin list"
}

echo "neovim:"
{
    echo "  :call dein:install() - install"
    echo "  :UpdateRemotePlugins"
}
