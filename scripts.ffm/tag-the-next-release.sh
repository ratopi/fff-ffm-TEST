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

echo
echo "Die aktuelle Entwicklungsversion ist: $currentversion"
echo

echo -n "Bitte gebe die gewuenschte Release-Version ein [Vorgabe: $tagversion] > "
read itagversion

echo -n "Bitte gebe die Version fuer die Entwicklung ein [Vorgabe: $nextversion] > "
read inextversion

if [ "$itagversion" ]; then
	tagversion="$itagversion"
fi

if [ "$inextversion" ]; then
	nextversion="$inextversion"
fi

echo
echo "Deine Wahl ist:"
echo "Release-Version....: $tagversion"
echo "Entwicklungsversion: $nextversion"
echo

echo -n "Wenn das korrekt ist gebe bitte 'OKAY' ein > "
read yesno

if [ "$yesno" != "OKAY" ]; then
	echo
	echo "Script wird auf Wunsch abgebrochen"
	echo
	exit 1
fi

# now checking if tagversion is already existing

if git tag -l | grep -q "^$tagversion$"; then
	echo
	echo "**** Das Tag '$tagversion' existiert bereits"
	echo
	exit 1
fi

# now we can start to do the work

# set version number and tag

echo "$tagversion" > "$versionfile"
git add "$versionfile"
git commit -m "version changed to '$tagversion' for new release (by $( basename "$0" ))"
git tag -a -m "release tag (by $( basename "$0" ))" "$tagversion"

# set new snapshot version

echo "$nextversion" > "$versionfile"
git add "$versionfile"
git commit -m "version changed to '$nextversion' for developing in master (by $( basename "$0" ))"

# done ...

echo
echo "Das Release-Tag '$tagversion' wurde erfolgreich angelegt."
echo
echo "Der master-Branch (Entwicklungszweig) steht nun auf Version '$nextversion'"
echo
echo "ACHTUNG! Bitte pushe das neue Tag und die Aenderung manuell mit dem folgenden Befehl zum Git-Server hoch:"
echo
echo "   git push origin $tagversion"
echo

