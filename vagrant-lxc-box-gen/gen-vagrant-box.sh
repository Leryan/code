#!/usr/bin/env bash

workdir=$(dirname $(readlink -f $0))
lxcpath=$(lxc-config lxc.lxcpath)
postscripts=("postscript-default.sh")

show_help() {
    echo -e "$0 -n container-name [-P lxc.lxcpath] [-N box-name] [-p postscript-name] [-p other-postscript-name]"
}

while getopts "hP:n:N:p:" opt; do
    case "${opt}" in
        h)
            show_help
            exit 0
            ;;
        P)
            lxcpath="${OPTARG}"
            ;;
        n)
            container="${OPTARG}"
            ;;
        N)
            newcontainer="${OPTARG}"
            ;;
        p)
            postscripts+=("postscript-${OPTARG}.sh")
            ;;
    esac
done

if [ -z $container ]; then
    echo ">>>> FAILURE: no container name defined."
    exit 1
fi

if [ -z $newcontainer ]; then
    newcontainer="${container}"
fi

if [ ! -d ${lxcpath}/${container} ]||[ -z ${container} ]; then
    echo ">>>> FAILURE: ${lxcpath}/${container} doesn't exists"
    exit 2
fi

postscript_failure=0
for postscript in "${postscripts[@]}"; do
    if [ ! -f ${workdir}/${postscript} ]; then
        echo ">>>> FAILURE: postscript ${workdir}/${postscript} not found"
        postscript_failure=1
    fi
done

if [ "${postscript_failure}" = "1" ]; then
    exit 3
fi

if [ ! -d ${lxcpath}/archives ]; then
    mkdir ${lxcpath}/archives
fi

cd ${lxcpath}/${container}

if [ ! -d vagrant ]; then
    mkdir vagrant
fi

echo ">>>> preparing vagrant rootfs"
rsync -aKSH --delete rootfs/* rootfs-vagrant

chmod +x rootfs-vagrant/root/passwd.sh

mv rootfs rootfs.pure
mv rootfs-vagrant rootfs

echo ">>>> starting container"
lxc-start -P ${lxcpath} -n ${container} -d
sleep 30

for postscript in "${postscripts[@]}"; do
    echo ">>>> running postscript: ${postscript}"
    cat ${workdir}/${postscript} > rootfs/root/postscript.sh
    chmod +x rootfs/root/postscript.sh
    lxc-attach -P ${lxcpath} -n ${container} --clear-env -- /root/postscript.sh
done

rm -f rootfs/root/passwd.sh rootfs/root/postscript.sh

echo ">>>> setup sudo"
echo "Defaults:vagrant !requiretty" >> rootfs/etc/sudoers
echo "vagrant ALL=(ALL:ALL) NOPASSWD:ALL" >> rootfs/etc/sudoers

echo ">>>> waiting for container to stop"
lxc-stop -P ${lxcpath} -n ${container} -t 20

echo ">>>> making archive"
tar --numeric-owner -cpzf vagrant/rootfs.tar.gz ./rootfs
#bsdtar -c --numeric-owner -zf vagrant/rootfs.tar.gz ./rootfs

mv rootfs rootfs-vagrant
mv rootfs.pure rootfs

echo '{"provider": "lxc", "version": "1.0.0"}' > vagrant/metadata.json
sed '/# NOT GENERIC #/,/# \/NOT GENERIC #/d' config > vagrant/lxc-config

vagrant_destination=${lxcpath}/archives/vagrant-lxc-${newcontainer}.box

rm -f ${vagrant_destination}
tar czf ${vagrant_destination} -C vagrant ./

echo ">>>> delete vagrant workdir"
rm -rf vagrant

echo ">>>> OK! Vagrant box: ${vagrant_destination}"
