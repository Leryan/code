#!/bin/sh
mds=$(find . -name "*.md");
for md in set $mds
do
	nmd=$(echo $md|sed 's/md$/markdown/g')
	echo $md $nmd
	mv $md $nmd
done
