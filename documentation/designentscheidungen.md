# Entscheidungsrational

## Design

### Material Design

Wir benutzen das *Material Design* von Google. *Material* ist ein anpassungsfähiges System von Richtlinien, Komponenten und Werkzeugen, die die besten Praktiken für die Gestaltung von Benutzeroberflächen unterstützen. Unterstützt durch Open-Source-Code optimiert *Material* die Zusammenarbeit zwischen Designern und Entwicklern und hilft Teams, schnell schöne Produkte zu entwickeln. Einige Teammitglieder haben bereits mit dem Material Design gearbeitet.

###  Figma

*Figma* ist ein mächtiges Tool für UI-Design und Prototyping. Wir haben im Zuge der Vorbereitung einen ausführlichen Prototypen mit diesem Tool erstellt.  




## Framework

### IOS/Android App

Schon früh in unserem Projekt entschieden wir uns dafür, eine Smartphone-App schreiben zu wollen. Während der Interviews mit den Schüler:innen und Lehrer:innen stellte sich heraus, dass im Unterricht viel mit Tablets gearbeitet wird. Außerdem hat inzwischen wohl fast jeder Schüler ein Smartphone. Allerdings hat nicht jeder Schüler einen Laptop, insbesondere nicht im Unterricht. Nach eigener Erfahrung ist die Benutzung einer Web-App auf dem Smartphone, auch wenn sie noch so gut ist, sehr schwierig. Deshalb die Entscheidung für eine Smartphone-App.

### Flutter

Wir wollten unbedingt eine Cross-Platform-App schreiben, damit sie auch von allen Schüler:innen benutzt werden kann. Um nicht je eine App pro Plattform entwickeln zu müssen und den Entwicklungsaufwand zu verringern, sollte ein Cross-Plattform-Framework verwendet werden. In die nähere Auswahl fielen *Flutter* und *React-Native*. Wir entschieden uns schließlich für *Flutter*. 

### Bloc 

Wir brauchten eine Zustandsverwaltungslösung und ein Kommilitone empfahl uns *flutter-bloc*. Es gibt viele Zustandsverwaltungslösungen, aus denen wir uns eine aussuchen mussten. *Bloc* versucht, Zustandsänderungen vorhersehbar zu machen, indem es regelt, wann eine Zustandsänderung auftreten kann, und einen einzigen Weg zur Zustandsänderung in der gesamten Anwendung erzwingt.