# Entscheidungsrational

## Design

### Material Design

In der App soll das *Material Design* von *Google* verwendet werden. *Material* ist ein anpassungsfähiges System von Richtlinien, Komponenten und Werkzeugen, die die besten Praktiken für die Gestaltung von Benutzeroberflächen unterstützen. Unterstützt durch Open-Source-Code optimiert *Material* die Zusammenarbeit zwischen Designern und Entwicklern und hilft Teams, schnell schöne Produkte zu entwickeln. Einige Teammitglieder haben bereits mit *Material Design* gearbeitet. Einen weiteren Vorteil stellt die Integration des *Material Designs* in die für die App-Entwicklung verwendete Technologie *Flutter* dar.

###  Figma

*Figma* ist ein mächtiges Tool für UI-Design und Prototyping. Im Zuge der Vorbereitung wurde für die App-Entwicklung mit *Figma* ein ausführlicher Prototyp erstellt. Auch in *Figma* gab es bereits Vorerfahrungen bei Teammitgliedern.

## Framework

### IOS/Android App

Schon früh im Projektablauf wurde sich für die Entwicklung einer Mobile-App entscheiden. Durch die Interviews mit den Schüler:innen und Lehrer:innen stellte sich heraus, dass im Unterricht viel mit Tablets gearbeitet wird. Außerdem ist die Nutzungsbarriere einer App sehr gering, da fast jede:r Schüler:in sowieso ein Smartphone besitzt. Im Vergleich dazu ist der Anteil der Schüler:innen, die einen Computer besitzen deutlich geringer - gerade wenn es um die Nutzung des Computers für und während des Schulunterrichts geht. Während auch webbasierte Technologien für die Entwicklung von Cross-Platform-Applications wie *Cordova* oder *Ionic* für die Entwicklung einer App infrage kamen, fiel die Entscheidung trotzdem zugunsten der Entwicklung einer nativen App aus, da die Benutzerfreundlichkeit von nativen Apps noch immer einen großen Pluspunkt darstellt.

### Flutter

Sehr wichtig für die Entwicklung der App war der Support für sämtliche Plattformen (im wesentlichen *Android* und *iOS*), sodass die Anwendung auch von sämtlichen Schüler:innen benutzt werden kann. Zur Auswahl standen im Team die Technologien *Flutter* und *React Native*, wobei schlussendlich *Flutter* ausgewählt wurde, wobei die Entscheidung hauptsächlich auf das global immer größer werdende Interesse an *Flutter* zurückzuführen war.  

### BLoC Pattern und flutter-bloc 

Wie auch in typischen Web-Anwendungen in *Angular*, *React*, etc. ist es auch in *Flutter* von enormer Wichtigkeit, eine gute Struktur zur Zustandsverwaltung in einer Anwendung zu implementieren. Neben der besseren Struktur hat eine gute Zustandsverwaltung auch oft mit Render-Zyklen der UI-Schicht zu tun, wobei viel Platz für Optimierung besteht. Im Kontext *Flutter* ist hierfür das sogennante *BLoC-Pattern* eines der beliebtesten Patterns. *BLoC* steht hierbei für *Business Logic Component* und stellt Systemkomponenten dar, in denen die Anwendungslogik abgekapselt von den Domänenmodellen und der Präsentationsschicht Platz findet. Derartige *BLoCs* bilden somit die View-Model-Schicht der MVVM-Architektur. 

Da das *BLoC-Pattern* ein sehr beliebtes Pattern in der *Flutter*-Entwicklung darstellt, exisitert eine Library namens *flutter-bloc*, welche es den Entwicklern ermöglicht, schnell und übersichtlich streambasierte *Business Logic Components* zu bauen, die einerseits hochperformant und optimiert und andererseits gut testbar sind.

### Datenhaltung

#### Betrachtete Möglichkeiten

##### Relationale Datenbanken

###### SQfLite

Grundlegender Adapter für SQLite Datenbanken mit Flutter.

**Pro**

- Basiert auf ausgereifter SQLite Datenbank
- Viel Dokumentation etc.

**Contra**

- Lediglich grundlegende DB-Schnittstelle: Keine Adapter für automatische Typisierung, Query-Generation etc.
- Keine Unterstützung für Migrationen
- Viel unnötiger Entwicklungsaufwand

###### Drift (früher Moor)

**Pro**

- ORM mit stark getypten Models
- Unterstützung von Schema-Migrationen für langfristige Datenhaltung
- Query-API und ergänzende Möglichkeit für manuelles SQL
- Ausgereift, viel Dokumentation, bekannt
- Aktiv gewartet

**Contra**

- Etwas mehr Entwicklungsaufwand als z.B. Hydrated BLoC

###### Floor

**Pro**

- ORM mit stark getypten Models
- Unterstützung von Schema-Migrationen für langfristige Datenhaltung
- Schönere und bekanntere Entity-Definition als Drift

**Contra**

- Weniger ausgereift als Drift
- Queries werden ausschließlich manuell per SQL geschrieben

##### NoSQL Lösungen

###### Hive

**Pro**

- Sehr einfaches Framework, wenig Boilerplate
- Häufig eingesetzt

**Contra**

- Keine Queriesprache: Filter etc. erst in Dart umsetzbar
- Keine Unterstützung für Migrations: Änderungen in Produktion werden sehr hässlich, da unter anderem die Typen von immutable sind: Es muss für jede Änderung eine neue Culumn angelegt werden

###### Hydrated BLoC

Einfache Lösung zur Persistierung von BLoc-Komponenten. Verwendet standardmäßig die grundlegenden Funktionen der Hive-NoSQL Datenbank zur tatsächlichen Abspeicherung, dies ist jedoch veränderbar.

**Pro**

- Sehr einfache Integration
- Wenig Boilerplate

**Contra**

- Handling von großen Listen: Dynamisches Nachladen etc. -> Muss alles selbst implementiert werden, da immer der ganze BLoC geladen wird?
- Keine Versionierung: Was passiert bei Veränderungen des BLoC? -> Eigener Test folgt.
- Nicht für langfristige Persistierung gedacht, sondern eher für Caching von einfachen Einstellungen wie im Beispiel des Entwicklers: https://medium.com/flutter-community/caching-bloc-state-with-hydrated-bloc-e565f81520a4
- Keine ausreichende Dokumentation. Z.B. fehlt die Integration in Apps mit State-Management (mit 'InitialState' etc., wie bei uns eingesetzt). Lediglich veraltete, nicht mehr funktionierende Tutorials von Drittanbietern sind zu diesen Thematiken vorhanden

###### Google Firebase

Ausgeschlossen, da es sich um eine cloudbasierte Lösung handelt. Die App zielt dagegen darauf ab, durch lokale Datenhaltung den Datenschutz zu gewähren und keinerlei Nutzerdaten gelesen werden können, weder von den Entwicklern, noch von Cloudanbietern.

Verschiedene Möglichkeiten zur Datensynchronisierung werden zu einem späteren Zeitpunkt in Betracht gezogen.

#### Ausgewählte Technologie: Relationale Datenbank SQLite mit ORM Drift (ehemals Moor)

**Grund für die Entscheidung**

Ausgereifte Lösung, die auch eine gute Strukturierung des Projekts ermöglicht und sich mit Migrations etc. auch für eine langfristige Weiterentwicklung der App eignet.


### Architektur

Es wurde eine vollständige Entkopplung der Persistenzschicht von der Business Logik erzielt. Zur Business Logik gehören die Data-Models und die BLoC Komponenten, sowie als Schnittstelle die DTOs sowie Repository-Interfaces.

Diese Interfaces werden in der Persistenzschicht mithilfe der relationalen Datenbank implementiert. Dazu werden Entitäten erstellt, die durch Codegenerierung auf die Data-Models der Business-Logik-Schicht gemappt werden.

Ebenfalls ist die Business-Logik vollständig unabhängig von der UI-Schicht.

Insgesamt ergibt sich somit eine Architektur, die sich an der Solution-Architecture / Clean-Architecture orientiert.