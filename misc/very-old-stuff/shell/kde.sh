#!/usr/bin/env sh

if [[ $TERM == "Linux" ]]
    sudo telinit 3
    yaourt -Syu
    yaourt -S kdebase kdegraphics okular kdegraphics gwenview skanlite k3b kdeutils ark zip unzip unrar
    cat /etc/inittab | grep -v "gdm" > /etc/inittab
    echo "x:5:respawn:/usr/bin/kdm -nodaemon" >> /etc/inittab
    sudo telinit 5
fi
