#!/usr/bin/env bash
if [[ $1 == "client" ]]; then
    if [[ $2 != "" ]]; then
        echo "Reset .minecraft."
        rm -f ~/.minecraft
        ln -sf `pwd`/minecraft_$2 $HOME/.minecraft
        shared=`ls shared_config/`
        echo "Setting shared config."
        for i in $shared; do
            ln -sf `pwd`/shared_config/$i $HOME/.minecraft/$i
        done
        echo "Launch minecraft launcher."
        java -jar client/minecraft.jar
    else
        echo "Error: \$2 doesn't exists."
    fi
elif [[ $1 == "server" ]]; then
    java -jar server/minecraft_server.jar nogui
else
    echo "Error: no choice ?"
fi
