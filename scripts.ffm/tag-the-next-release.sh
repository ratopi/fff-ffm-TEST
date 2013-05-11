#!/bin/bash

currentversion="$( cat ../files/etc/freifunk_version )"

#

if [ "$1" ]; then
	tagversion="$1"
else
	tagversion="$( echo "$currentversion" | sed -e 's:-SNAPSHOT$::' )"
fi

#

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
echo "# I propose the tag version and the next version will be the following, please edit to your conceirns:"
echo
echo "tagversion=$tagversion"
echo "nextversion=$nextversion"
echo
) > "$vfile"

vi "$vfile"

. "$vfile"

echo
echo "You entered:"
echo
echo "tagversion  = $tagversion"
echo
echo "nextversion = $nextversion"
echo

