#!/bin/bash

# preferences

versionfile="$( dirname "$0" )/../files/etc/freifunk_version"

currentversion="$( cat "$versionfile" )"

# test for first parameter containing the tag version

if [ "$1" ]; then
	tagversion="$1"
else
	tagversion="$( echo "$currentversion" | sed -e 's:-SNAPSHOT$::' )"
fi

# test for second parameter containing the new snapshot version number

if [ "$2" ]; then
	nextversion="$2"
else
	nextversion="$( echo "$currentversion" | sed -e 's:-.*::' | awk -F. -v OFS=. 'NF==1{print ++$NF}; NF>1{if(length($NF+1)>length($NF))$(NF-1)++; $NF=sprintf("%0*d", length($NF), ($NF+1)%(10^length($NF))); print}' )-$( echo "$currentversion" | sed -e 's:^[^-]*-::')"
fi

#

vfile="/tmp/vfile.$$"

(
echo "# Please specify the wanted tag version and next version number"
echo "#"
echo "# The current version is"
echo "#"
echo "# $currentversion"
echo "#"
echo "# I propose the tag version and the next version will be the following:"
echo
echo "tagversion=$tagversion"
echo "nextversion=$nextversion"
echo
) > "$vfile"

vi "$vfile"

. "$vfile"

echo
echo "You entered:"
echo "tagversion  = $tagversion"
echo "nextversion = $nextversion"
echo

# now checking if tagversion is already existing

if git tag -l | grep -q "^$tagversion$"; then
	echo "**** The tag '$tagversion' is already exisiting"
	echo "**** Script will be aborted"
	echo
	exit 1
fi

# now we can start to do the work

# set version number and tag

echo "$tagversion" > "$versionfile"
git add "$versionfile"
git commit -m "version changed to '$tagversion' for new release (by script $( basename "$0" ))"
git tag -a -m "release tag (by script $( basename "$0" ))" "$tagversion"

# set new snapshot version

echo "$nextversion" > "$versionfile"
git add "$versionfile"
git commit -m "version changed to '$nextversion' for developing in master (by script $( basename "$0" ))"

# done ...

echo
echo "we are successfully created the new tag"
echo "* $tagversion"
echo
echo "the master is now at version"
echo "* $nextversion"
echo
echo "IMPORTANT! Please push up the new tag and the changes with:"
echo
echo "   git push origin $tagversion"
echo

