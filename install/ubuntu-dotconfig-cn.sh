#!/bin/bash

function is_installed {
    dpkg-query -W -f='${Status}' $1 2>/dev/null | grep -c "ok installed"
}

devops_dir="$HOME/.devops"

[ $(is_installed git) -eq 0 ] && sudo apt install git

[ ! -d "$devops_dir" ] \
    && git clone https://github.com/tecposter/devops.git $devops_dir

bash "$devops_dir/ubuntu-dotconfig-cn.sh"
