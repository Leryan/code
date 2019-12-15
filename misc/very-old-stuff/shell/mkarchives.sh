#!/usr/bin/env bash
project="les-indemodables"
user=`cat ~/.hgrc | egrep "[gc]*.username" | awk {'print $3'}`
pass=`cat ~/.hgrc | egrep "[gc]*.password" | awk {'print $3'}`
read -p "Version : " version
tar -czf Les-Jeux-Indemodables_src_$version.tgz -C src/ *.c *.h ./*/*.c ./*/*.h *.rc Make* patron ressources.rc icon.ico
tar -czf Linux_$version.tgz exe-linux
tar -xzf Windows_$version.tgz exe-win
tar -czf common-datas_$version.tgz -C src/ sons niveaux historiques.lst dico.ini playList.m3u credits.lst
upld="N"
read -p "Upload ? [y/N]" upld
if [[ $upld == "y" ]]; then
    echo "Uploading files..."
    googlecode_upload.py -s "Données communes : sons, niveaux, etc..." -p $project -u $user -w $pass -l "Featured" common-datas_$version.tgz
    googlecode_upload.py -s "Sources stables" -p $project -u $user -w $pass -l "Featured" Les-Jeux-Indemodables_src_$version.tgz
    googlecode_upload.py -s "Exécutables Linux i386-x86_64" -p $project -u $user -w $pass -l "Featured" Linux_$version.tgz
    googlecode_upload.py -s "Exécutables Windows" -p $project -u $user -w $pass -l "Featured" Windows_$version.zip
    echo "Files uploaded.
    End Of Line."
else
    echo "End Of Line."
fi
