# scripts.ffm

Dieses Verzeichnis enthält unterschiedliche Scripte, die den Build-Prozess vereinfachen und unterstützen sollen.

## tag-the-next-release.sh

Dieses Script legt ein Tag mit der nächsten Versionsnummer an.
Die Schritte im einzelnen:

* Abfrage der gewünschten Versionsnummer und nächsten Snapshot-Versionsnummer. Das Script schlägt hierbei die Versionsnummern vor, die normalerweise passen sollten.  Falls nicht können sie geändert werden.
* Änderung der Dateien, die die Versionsnummer enthalten: Setzen der nächsten Version
* Commit der Änderungen
* Tagging mit der gewählten Versionsnummer
* Änderung der Dateien, die die Versionsnummer enthalten: Setzen der nächsten Snapshot-Version
* Commit der Änderungen

Danach steht im neuen Tag, die getaggte Version zur Verfügung und kann mit

	git checkout <Versionsnummer>

ausgecheckt werden.

Der master enthält immer eine SNAPSHOT-Version mit der vorraussichtlichen nächsten Versionsnummer als Basis.

**Achtung!!!** Das Script führt momentan **kein** Git-Push aus.  Der Befehl

	git push <Versionsnummer>

sollte daher zeitnah nach dem Ausführen des Scripts durchgeführt werden.

