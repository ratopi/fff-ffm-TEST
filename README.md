# Firmware von Freifunk Frankfurt am Main

Dieses Repository enthält die Freifunk-Firmware, so wie sie im Freifunk-Netz in Frankfurt am Main (Ffm) verwendet wird.
Es ist ein Fork der KBU-Firmware, die wie lff wiederum ein Fork der Lübecker Firmwarest.

Weitere Informationen zu unserem Freifunk Netz findest Du unter [Wiki Freifunk Frankfurt](http://wiki.freifunk.net/Freifunk_Frankfurt).
Hier findest Du auch Informationen von wo Du die aktuell empfohlene Firmware herunterladen kannst.

## Versionierung

Die Versionsnummern sind fest in den Dateien in den entsprechenden Tags eingebaut.
Der *master* steht hierbei stets auf der (vorrausichtlichen) nächsten Version mit dem Anhang "-SNAPSHOT".

Beispiele:

* Version 1.0 befindet sich im Tag "1.0"
** Der *master* enthält entsprechend dann die Version "1.0.1-SNAPSHOT"

*Anmerkung:* Momentan verbinden sich unsere Firmwares noch mit Supernodes aus dem KBU-Netz.
Zur deutlichen Unterscheidung tragen unsere Versionsnummer daher im Moment noch den *Infix* "-ffm-" zur Kennzeichnung.
Dieser *Infix* wird entfallen wenn unsere Firmware sich nur noch mit unseren Supernodes verbindet.

Zur Vereinfachung des Tagging-Vorgangs ist das Script "scripts.ffm/tag-the-next-release.sh" vorhanden.
Es fragt die gewünschten Versionsnummer ab und kümmert sich um den Rest.


## Repository-Struktur

Wir verwenden momentan nur einen Branch ("master"), welche aus dem KBU branch "0.3-generic" hervorgegangen ist.


## Build
Unsere Build-Scripte befinden sich im Verzeichnis "scripts.ffm/".
Diese Build-Scripte sind aus dem Code aus dem KBU-Jenkins abgeleitet.

