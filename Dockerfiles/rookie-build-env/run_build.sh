#!/bin/bash

if [ -d .repo ]; then
	repo forall -c 'pwd; git clean -xdf; git reset HEAD --hard'
else
	echo "There is no repo"
	exit -1;
fi

repo init -u ssh://git@gitlab.rbtree.com/pettra/android/platform/manifest.git -b master-pf -b --depth=1

repo sync -c -j8 --no-tags

./device/nexell/tools/build.sh -b s5p6818_rookie
