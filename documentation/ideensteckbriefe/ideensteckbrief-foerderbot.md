# Ausarbeitung – App für Antragstellung

### Thema

Selbst in gesellschaftlich fortschrittlichen Ländern wie Deutschland ist und bleibt Bildung oft nur für die Privilegierten zugänglich. Einer der häufigsten Gründe hierfür sind die mit Bildung  (Studium, Schule, etc.) verbundenen Kosten. In Deutschland existiert eine Vielzahl von Förderungen für sämtliche Gesellschaftsgruppen, jedoch gibt es hierfür klare Barrieren. Zum einen sind sich viele Menschen nicht darüber im Klaren, dass derartige Förderungen existieren, während zum anderen die, die von der Existenz der Förderungen wissen, oft Schwierigkeiten bei der Beantragung erwähnter Fördermittel haben. 

Genau an diesen beiden Punkten setzt die Idee für das Software Engineering Projekt an: es soll eine softwarebasierte Lösung entwickelt werden, die Personen bei der Suche und der Beantragung von Fördermitteln unterstützt, wobei der Fokus klar auf Schüler jeden Alters gerichtet ist. In einem Chatbot-basierten System soll es den Nutzern einfach gemacht werden, die nötigen Informationen für die jeweiligen Formulare ohne unnötige Komplexität einzutragen. 

Es ist außerdem denkbar, dass das System Nutzer unterstützt zu erkennen, welche Fördermittel für sie infrage kommen bzw. von vornherein ausgeschlossen werden können.  

### Technische Aspekte

Da die Softwarelösung speziell darauf zielt Barrieren zu verkleinern, bietet es sich an, die Lösung als Mobile-App für Smartphones mit potenzieller Webanwendung für PC-Nutzer zu entwickeln. Das in der Vorlesung angesprochene Expert-Pattern ist für die Idee der Anwendung essenziell: das Wissen, welche Informationen für ein Formular notwendig sind, soll mit der Anwendung nicht mehr bei der ausfüllenden Person sondern beim Formular selbst liegen. So ist es denkbar, dass Förderstiftungen o.ä. in Zusammenarbeit mit den Entwicklern ein Formular mit Expertenwissen in das System einpflegen. 

Hat ein Nutzer alle durch den Chatbot erfragten Informationen für ein Formular angegeben, soll das Formular durch die Anwendung vorausgefüllt zur Verfügung gestellt werden. Die eingegebenen Informationen können für weitere Formularausfüllungen gespeichert werden, sodass ähnliche Daten (Name, Adresse, Versichertennummer, etc.) ab jetzt nicht mehr erfragt werden müssen. 

Ein herausragender Aspekt hierbei ist, dass es in keiner Weise nötig ist, die Informationen auf externen Servern zu speichern – es reicht vollkommen aus, die Daten auf dem Gerät lokal abzulegen. So wird einerseits die Hemmschwelle zur Angabe persönlicher  Daten gesenkt, und andererseits die Datensicherheit immens erhöht.
