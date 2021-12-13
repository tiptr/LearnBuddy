# Entscheidungsrational

## Design

### Material Design

In der App soll das Material Design von Google verwendet werden. Material ist ein anpassungsfähiges System von Richtlinien, Komponenten und Werkzeugen, die die besten Praktiken für die Gestaltung von Benutzeroberflächen unterstützen. Unterstützt durch Open-Source-Code optimiert Material die Zusammenarbeit zwischen Designern und Entwicklern und hilft Teams, schnell schöne Produkte zu entwickeln. Einige Teammitglieder haben bereits mit dem Material Design gearbeitet. Einen weiteren Vorteil stellt die Integration des Material Designs in die für die App-Entwicklung verwendete Technologie Flutter dar.

###  Figma

Figma ist ein mächtiges Tool für UI-Design und Prototyping. Im Zuge der Vorbereitung wurde für die App-Entwicklung mit Figma ein ausführlicher Prototyp erstellt. Auch in Figma gab es bereits Vorerfahrungen bei Teammitgliedern.

## Framework

### IOS/Android App

Schon früh im Projektablauf wurde sich für die Entwicklung einer Mobile-App entscheiden. Aus den Interviews mit den Schüler:innen und Lehrer:innen kam heraus, dass viel im Unterricht mit Tablets gearbeitet wird. Außerdem ist die Nutzungsbarriere einer App sehr gering, da fast jede:r Schüler:in sowieso ein Smartphone besitzt. Im Vergleich dazu ist der Anteil der Schüler:innen, die einen Computer besitzen deutlich geringer - gerade wenn es um die Nutzung des Computers für und während des Schulunterrichts geht. Während auch webbasierte Technologien für die Entwicklung von Cross-Platform-Applications wie Cordova oder Ionic für die Entwicklung einer App infrage kämen, wurde sich trotzdem für die Entwicklung einer nativen App entschieden, da die Benutzerfreundlichkeit von nativen Apps noch immer einen großen Pluspunkt darstellt.

### Flutter

Sehr wichtig für die Entwicklung der App war der Support für sämtliche Plattformen (im wesentlichen Android und iOS), sodass die Anwendung auch von sämtlichen Schüler:innen benutzt werden kann. Zur Auswahl standen im Team die Technologien Flutter und React Native, wobei sich schlussendlich für Flutter entschieden wurde, wobei die Entscheidung hauptsächlich auf das global immer größer werdende Interesse an Flutter zurückzuführen war.  

### BLoC Pattern und flutter-bloc 

Wie auch in typischen Web-Anwendungen in Angular, React, etc. ist es auch in Flutter von enormer Wichtigkeit eine gute Struktur zur Zustandsverwaltung in einer Anwendung zu implementieren. Neben der besseren Struktur hat eine gute Zustandsverwaltung auch oft mit Render-Zyklen der UI-Schicht zu tun, wobei viel Platz für Optimierung besteht. Im Kontext Flutter ist hierfür das sogennante BLoC-Pattern eines der beliebtesten Patterns. BLoC steht hierbei für Business Logic Component und stellt Systemkomponenten dar, in denen die Anwendungslogik abgekapselt von den Domänenmodellen und der Präsentationsschicht Platz findet. Derartige BLoCs bilden somit die View-Model-Schicht der MVVM-Architektur. 

Da das BLoC-Pattern ein sehr beliebtes Pattern in der Flutter-Entwicklung darstellt, exisitert eine Library namens flutter-bloc, welche es den Entwicklern ermöglicht, schnell und übersichtlich streambasierte Business Logic Components zu bauen, die einerseits hochperformant und optimiert und andererseits gut testbar sind.