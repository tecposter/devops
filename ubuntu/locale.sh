#!/bin/bash

locale_file="/etc/default/locale"
profile_file="$HOME/.profile"

if !  grep -Fq "LANG=" "$locale_file" ; then
    echo 'LANG="en_US.UTF-8"' | sudo tee -a $locale_file > /dev/null
    echo "$locale_file: LANG=\"en_US.UTF-8\""
fi

if !  grep -Fq "LANGUAGE=" "$locale_file" ; then
    echo 'LANGUAGE="en_US.UTF-8"' | sudo tee -a "$locale_file" > /dev/null
    echo "$locale_file: LANGUAGE=\"en_US.UTF-8\""
fi

if !  grep -Fq "LC_ALL=" "$locale_file" ; then
    echo 'LC_ALL="en_US.UTF-8"' | sudo tee -a "$locale_file" > /dev/null
    echo "$locale_file: LC_ALL=\"en_US.UTF-8\""
fi

if [ -z "$LC_CTYPE" ]; then
    echo 'export LC_CTYPE=en_US.UTF-8' >> "$profile_file"
    export LC_CTYPE=en_US.UTF-8
    echo "$profile_file: LC_CTYPE=en_US.UTF-8"
fi

if [ -z "$LC_ALL" ]; then
    echo 'export LC_ALL=en_US.UTF-8' >> "$profile_file"
    export LC_ALL=en_US.UTF-8
    echo "$profile_file: LC_ALL=en_US.UTF-8"
fi
