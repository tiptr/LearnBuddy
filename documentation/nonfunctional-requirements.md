# Nicht-funktionale Anforderungen
### Benutzbarkeit
+ **NFA01**: Das Einrichten der grundlegenden Einstellungen beim ersten Öffnen der App muss innerhalb von 30 Sekunden möglich sein.
+ **NFA02**: Das System muss für Schüler ab der vierten Klasse intuitiv nutzbar sein, sodass ein durchschnittlicher Schüler, der zuvor noch nie die App benutzt hat, innerhalb von 60 Sekunden bewusst mithilfe der unteren Menüleiste durch die einzelnen Teile der App navigieren kann. 
+ **NFA03**: Das Starten eines Timers muss innerhalb von zwei Clicks nach dem Öffnen der App möglich sein.
+ **NFA04**: Die App muss offline - bis auf das dynamische Laden von Ausgleichsübungen - vollständig funktionsfähig sein.
### Zuverlässigkeit
+ **NFA05**: Sicherheit - Sämtliche privaten Daten des Schülers werden ausschließlich lokal auf dem Smartphone des Schülers gespeichert.
+ **NFA06**: Die App darf nicht aufgrund von zufälligen beliebigen Benutzereingaben abstürzen.
+ **NFA07**: Benachrichtigungen zu anstehenden Deadlines müssen zum vorhergesehenen Zeitpunkt abgesendet werden und dürfen insbesondere nicht erst nach Ablauf der Deadline erscheinen.
### Effizienz
+ **NFA08**: Jede Benutzereingabe muss innerhalb von maximal zwei Sekunden verarbeitet werden.
+ **NFA09**: Stromverbrauch - Die Verwendung der App darf die Akkulaufzeit nicht mehr als 20% im Vergleich zu Full-HD-Videowiedergabe verringern.
### Wartbarkeit
+ **NFA10**: Die App muss über den _Google Play_, bzw. den _Appstore_, geupdated werden können.
+ **NFA11**: Der Sourcecode der App muss gut struktiert und dokumentiert sein, sodass sich ein erfahrener Softwareentwickler innerhalb von einer Stunde in den Code einlesen und diesen verstehen kann.
### Übertragbarkeit
+ **NFA12**: Die App muss auf mobilen Endgeräten mit _iOS_ (ab Version _iOS 14_) oder _Android_ (ab Version _Android 11_) Betriebssystem installiert werden können.
### Constraints
+ **NFA13**: Die App wird plattformübergreifend mithilfe von _Flutter_ entwickelt.