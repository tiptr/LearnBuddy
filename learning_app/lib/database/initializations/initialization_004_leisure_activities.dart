import 'package:drift/drift.dart';
import 'package:learning_app/features/leisure/persistence/leisure_activities_dao.dart';
import 'package:learning_app/util/injection.dart';
import '../database.dart';

/// Initialization of database entries: leisure activities
///
/// This file is called from inside database.dart. Future initialization scripts
/// have to be explicitly added there, too.
Future<void> initialization004LeisureActivities() async {
  final LeisureActivitiesDao _dao = getIt<LeisureActivitiesDao>();
  // Batch insert, no awaits required inside
  await _dao.batch((batch) {
    batch.insertAll(_dao.leisureActivities, [
      // Fun Challenges
      LeisureActivitiesCompanion.insert(
        id: const Value(0),
        leisureCategoryId: 0,
        name: 'Grinsende Katzen',
        duration: const Duration(minutes: 10),
        descriptionShort:
            'Zeichne auf einem Papier fünf Katzen mit verschiedenen fröhlichen menschlichen Gesichtsausdrücken.\n Teilt die Bilder innerhalb eurer Klasse und identifiziert euren Picasso.',
        descriptionLong: 
          const Value<String>('Überlege dir, was es für verschiedene Arten gibt, Freude zu zeigen. Was ist der Unterschied zwischen einem Lachen, Grinsen und schmunzeln? Versuche das in deine Bilder der Katzen mit einfließen zu lassen. Alle sollen individuell aussehen. Lass uns die Unterschiedlichkeit feiern!'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-fun-smiling-cats.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(1),
        leisureCategoryId: 0,
        name: 'Verrückte Katzen',
        duration: const Duration(minutes: 10),
        descriptionShort:
            'Zeichne auf einem Papier fünf Katzen mit verschiedenen menschlichen Gesichtsausdrücken.\n Teilt die Bilder innerhalb eurer Klasse und identifiziert euren Picasso.',
        descriptionLong: 
          const Value<String>('Überlege dir, was es für verschiedene Menschliche Gesichtsausdrücke gibt. Manche sind fröhlich, manche traurig, manche nachdenklich und noch viel mehr! Versuche diese Gefühle durch deine Katzen auszudrücken. Alle sollen individuell aussehen. Lass uns die Unterschiedlichkeit feiern!'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-fun-crazy-cats.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(2),
        leisureCategoryId: 0,
        name: 'Verwirrung!',
        duration: const Duration(minutes: 10),
        descriptionShort:
            'Kreise die linke Hand auf deinem Bauch und gleichzeitig klopfe deinen Kopf mit der rechten Hand. Kannst du es auch umgekehrt?',
        descriptionLong: 
          const Value<String>('Lege deine linke Hand auf deinen Bauch. Platziere deine rechte Hand auf deinem Kopf. Nun versuche deine linke Hand kreisförmig zu bewegen. Wenn du das geschafft hast, klopfe mit der rechten Hand sanft auf deinen Kopf. Schaffst du es beide Bewegungen gleichzeitig zu machen? Wenn ja, versuche doch einmal deine Hände zu tauschen.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-fun-confusion.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(3),
        leisureCategoryId: 0,
        name: 'Zunge Rollen',
        duration: const Duration(minutes: 10),
        descriptionShort:
            'Versuche deine Zunge einzurollen.',
        descriptionLong: 
          const Value<String>('Manche Menschen können ihre Zunge rollen. Schaffst du das auch? Keine Sorge, manchmal braucht es ein bisschen Übung. Gib nicht auf!'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-fun-roll-tongue.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(4),
        leisureCategoryId: 0,
        name: 'Luftballon Challenge',
        duration: const Duration(minutes: 15),
        descriptionShort:
            'Halte einen Luftballon so lange in der Luft wie du es schaffst.',
        descriptionLong: 
          const Value<String>('Alles ist erlaubt. Du darfst den Luftballon mit deinen Füßen, Armen, ja deinem ganzen Körper in der Luft halten. Aber pass auf, dass er nicht den Boden berührt! Wie lange kannst du es schaffen?'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-fun-balloon.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(5),
        leisureCategoryId: 0,
        name: 'Ohne Hände trinken',
        duration: const Duration(minutes: 5),
        descriptionShort:
            'Schenke dir einen Becher Wasser ein. Schaffst du ihn zu trinken ohne deine Hände zu benutzen?',
        descriptionLong: 
          const Value<String>('Nehme kein Glas! Es sollte ein Plastikbecher sein. Lasse nun deine Hände auf deinem Rücken. Schaffst du es den Becher auszutrinken ohne deine Hände zur Hilfe zu nehmen?'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-fun-drink-without-hands.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(6),
        leisureCategoryId: 0,
        name: 'Blindes Zeichnen',
        duration: const Duration(minutes: 5),
        descriptionShort:
            'Suche dir ein Motiv deiner Wahl und zeichne es ohne hinzuschauen.',
        descriptionLong: 
          const Value<String>('Du kannst deinen Kater, deine Freunde, dein Zimmer, oder ähnliches Zeichnen. Sei kreativ! Überlege dir genau wie es aussehen soll und schließe dann deine Augen. Versuche dein Motiv so gut wie möglich zu zeichnen, ohne deine Augen zu öffnen!'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-fun-paint-blindly.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(7),
        leisureCategoryId: 0,
        name: 'Kartenhaus Challenge',
        duration: const Duration(minutes: 10),
        descriptionShort:
            'Nimm ein Kartendeck und versuche das höchste Kartenhaus zu bauen, was du jemals errichtet hast!',
        descriptionLong: 
          const Value<String>('Ein Kartenhaus baust du, indem du zwei Karten zu einem Dreieck zusammenstellst. Die Karten berühren sich also an den Spitzen, aber ihre Enden sind von einander entfernt. Nun baust du mehrere Dreiecke nebeneinander. Danach kannst du über je zwei Dreiecke eine neue Karte legen. Nun hast du schon eine Etage geschafft! Kannst du noch höher bauen?'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-fun-home.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(8),
        leisureCategoryId: 0,
        name: 'Zitronen Challenge',
        duration: const Duration(minutes: 10),
        descriptionShort:
            'Iss eine Scheibe Zitrone ohne das Gesicht zu verziehen!',
        descriptionLong: 
          const Value<String>('Schaffst du es in eine Scheibe Zitrone zu beißen, ohne dass du das Gesicht verziehst? Wer von deinen Freunden hat seine Gesichtszüge am Besten unter Kontrolle während er die Zitronenscheibe isst?'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-fun-lemon.svg'),
      ),
      /**************************************************************************************************/
      //Fitness ohne Geräte
      LeisureActivitiesCompanion.insert(
        id: const Value(9),
        leisureCategoryId: 1,
        name: 'Dips am Stuhl',
        duration: const Duration(minutes: 5),
        descriptionShort:
            '10 Dips, dann eine Kurze Pause',
        descriptionLong: 
          const Value<String>('Stelle deine Beine Hüftbreit auf. Drehe dem Stühl deine Rücken zu. Fasse nun mit deinen Händen an die Seiten der Sitzfläche. Versuche deinen Oberkörper gerade zu halten und senke dein Gesäß bis kurz über den Boden ab. Drücke dich danach wieder hoch.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-fitness-dips.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(10),
        leisureCategoryId: 1,
        name: 'Liegestütze',
        duration: const Duration(minutes: 5),
        descriptionShort:
            '10 Liegestütze, dann eine kurze Pause',
        descriptionLong: 
          const Value<String>('Den Kopf beim Liegestütz in einer Linie mit dem Körper halten und nicht überstrecken. Der Blick ist auf den Boden gerichtet. Den Körper in einer Linie halten, das Gesäß nicht erhöhen. Senke dich tief bis zum Boden ab. Achte auf gleichmäßige Bewegungen und versuche Ruckartiges zu vermeinden. Strecke deine Arme nicht ganz durch. Atme aus beim Hochdrücken und ein beim Absenken.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-fitness-pushups.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(11),
        leisureCategoryId: 1,
        name: 'Kniebeugen',
        duration: const Duration(minutes: 5),
        descriptionShort:
            '10 Kniebeugen, dann eine kurze Pause',
        descriptionLong: 
          const Value<String>('Stelle Dich mit hüftbreit geöffneten Füßen aufrecht hin. Schiebe nun Deinen Po nach hinten, beuge die Knie und senke Dein Gesäß so weit nach unten, bis Deine Knie etwas mehr als 90° gebeugt sind. Achte darauf, dass die Knie nicht über die Fußspitzen nach vorne geschoben werden. Halte diese Position einen kleinen Augenblick, bevor Du Dich kraftvoll, aber langsam wieder nach oben drückst und die Beine Streckst. Achte darauf, dass Dein Rücken gerade ist und Deine Fersen fest am Boden verankert sind. Wenn es Dir hilft, kannst Du die Fußspitze etwas anziehen, so dass sich Dein Gewicht mehr auf die Fersen verlagert.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-fitness-knee.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(12),
        leisureCategoryId: 1,
        name: 'Im Stand joggen',
        duration: const Duration(minutes: 5),
        descriptionShort:
            'jogge im stehen',
        descriptionLong: 
          const Value<String>('Halte deine Arme leicht gewinkelt an deinem Körper und bewege sie rhytmisch mit. Wenn dein linkes Knie nach oben geht, so geht dein rechter Ellenbogen nach vorne und umgekehrt. Versuche nicht zu trampeln, sondern gut zu federn mit deinen Knien.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-fitness-standing-run.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(13),
        leisureCategoryId: 1,
        name: 'Planke mit gestreckten Knien',
        duration: const Duration(minutes: 5),
        descriptionShort:
            'Halte einen Plank dreimal so lange du kannst',
        descriptionLong: 
          const Value<String>('Setze die Knie auf dem Boden ab, platziere Deine Unterarme auf den Boden (so dass die Ellenbogen unterhalb der Schultergelenke sind) und stemme Dich nach oben. Spanne dabei Deinen Bauch und Po fest an und achte darauf, dass Dein Körper eine gerade Linie bildet. Halte auch in den Schultergelenken Spannung. Vergewissere Dich, dass Du kein Hohlkreuz machst und Dein unterer Rücken nicht durchhängt. Halte diese Position für einige Sekunden und mache dann keine kurze Pause, indem Du die Knie wieder auf dem Boden absetzt oder Dich flach auf den Boden legst.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-fitness-planke.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(14),
        leisureCategoryId: 1,
        name: 'Burpees',
        duration: const Duration(minutes: 5),
        descriptionShort:
            'Mache so viele Burpees wie du schaffst.',
        descriptionLong: 
          const Value<String>('Stelle Dich zunächst hüftbreit und aufrecht auf Deine Füße, bevor Du in die breite Hocke gehst und Deine Hände ebenfalls hüftbreit vor Deine Füße auf dem Boden aufstellst. Springe nun mit beiden Füßen gleichzeitig nach hinten und mache einen Liegestütz. Im Anschluss daran springst Du mit beiden Füßen wieder nach vorn in die Hocke und richtest Dich auf. Achtung: Die Knie sind nun noch leicht gebeugt, die Arme nach hinten gestreckt. Nun schwingen Deine Arme kraftvoll nach vorn und oben, Dein gesamter Körper folgt ihnen in einen kraftvollen Strecksprung nach oben. Nachdem Du nun wieder in der Ausgangsposition gelandet bist, wiederholt sich der ganze Ablauf, wie bereits beschrieben.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-fitness-planke-burpees.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(15),
        leisureCategoryId: 1,
        name: 'Mountain Climbers (Bergsteiger)',
        duration: const Duration(minutes: 10),
        descriptionShort:
            'Mache so viele Bergsteiger wie du schaffst.',
        descriptionLong: 
          const Value<String>('Nehme zunächst die Liegestütz-Startposition ein. Achte besonders darauf, dass Dein Körper eine gerade Linie bildet und Du von den Fußspitzen bis zum Nacken Deinen gesamten Körper angespannt hast. Kontrolliere noch einmal, ob Deine Hände sich auch wirklich direkt unter Deinen Schultern befinden, bevor Du startest. Ziehe abwechselnd das linke und das rechte Bein an den Oberkörper und versuche mit Deinen Knien die Brustmuskulatur zu berühren. Strecke das Bein nun wieder, stelle den Fuß ab und mache das Gleiche mit der anderen Seite.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-fitness-mountain-climber.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(16),
        leisureCategoryId: 1,
        name: 'Arm-/Beinheben im Vierfüßlerstand',
        duration: const Duration(minutes: 5),
        descriptionShort:
            'Mache so viele wiederholungen wie du schaffst.',
        descriptionLong: 
          const Value<String>('Deine Ausgangsposition für die Übung ist der Vierfüßlerstand: Der Kopf verlängert deine gerade ausgerichtete Wirbelsäule. Spanne den Bauch und den Beckenboden an, damit kein Hohlkreuz entsteht. Hebe den rechten Arm vom Boden ab und strecke ihn in Verlängerung des Oberkörpers weit nach vorne heraus. Gleichzeitig hebst du dein linkes Bein an und streckst es in Verlängerung des Rumpfes gerade nach hinten heraus. Halte diese Position kurz, gehe zurück in die Ausgangsposition und wechsle zum jeweils anderen Arm bzw. Bein. Variante: Bei der dynamischen Ausführung setzt du Arm und Bein nicht gleich wieder auf dem Boden ab, sondern führst Ellbogen und Knie zusammen, so dass ein Rundrücken entsteht.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-fitness-standard.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(17),
        leisureCategoryId: 1,
        name: 'Armstütz mit Beinheben',
        duration: const Duration(minutes: 5),
        descriptionShort:
            'Mache so viele Wiederholungen wie du schaffst.',
        descriptionLong: 
          const Value<String>('Geh zunächst in den Vierfüßerstand auf die Matte und nimm dann eine Liegestützposition ein. Strecke Deine Beine fast vollständig durch, stemme dann den Po in Richtung Decke und stell Dich auf die Zehenspitzen. Deine Wirbelsäule ist jetzt parallel zum Boden ausgerichtet. Spanne den gesamten Rumpf fest an und hebe ein Bein vom Boden ab, bis das Bein ebenfalls parallel zum Boden ausgerichtet ist und in Verlängerung der Wirbelsäule eine gerade Linie mit dem Oberkörper bildet. Halte diese Position für einige Sekunden und stell dann das Bein wieder ab. Wiederhole die Übung mit dem anderen Bein.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-fitness-leg-lift-planke.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(18),
        leisureCategoryId: 1,
        name: 'Bauchpresse/Crunch',
        duration: const Duration(minutes: 5),
        descriptionShort:
            'Mache so viele Wiederholungen wie du schaffst.',
        descriptionLong: 
          const Value<String>('Ausgangsposition für die Crunches ist die Rückenlage. Deine Beine stehen angewinkelt auf dem Boden, die Füße sind hüftbreit aufgestellt. Spanne die Muskulatur im Bauch an, indem Du den Nabel Richtung Rücken einziehst. Leg die Hände in den Nacken, die Fingerspitzen berühren sich, die Ellbogen sind angewinkelt. Hebe die Arme, den Kopf und den oberen Rücken einige Zentimeter vom Boden ab und senke sie dann wieder ab, ohne sie ganz abzulegen. Die Kraftanstrengung kommt dabei aus dem Bauch.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-fitness-standard.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(19),
        leisureCategoryId: 1,
        name: 'Bauchpresse/Crunch diagonal',
        duration: const Duration(minutes: 5),
        descriptionShort:
            'Mache so viele Wiederholungen wie du schaffst.',
        descriptionLong: 
          const Value<String>('In der Ausgangsposition liegst Du mit dem Rücken auf der Matte, deine Beine sind fast ganz durchgestreckt, die Arme liegen links und rechts parallel zum Körper auf dem Boden. Hebe nun deinen rechten Arm fast ganz durchgestreckt an, bewege ihn in einem Halbkreis hinter den Kopf und lege ihn dort ab. Hebe dann mit der Einatmung dein linkes Bein, bis dein Oberschenkel auf etwa 90° Grad zum Rumpf gebeugt ist. Gleichzeitig hebst du deinen rechten Arm und führst ihn fast ganz durchgestreckt über die Körpermitte, bis sich deine Fingerspitzen und dein Bein berühren. Mit der Aufwärtsbewegung des Arms hebt deine Schulter und deine Brustwirbelsäule ein kleines Stück vom Boden ab, dein Oberkörper rollt sich auf dieser Seite leicht ein. Bewege den Oberkörper, deinen Arm und dein Bein dann mit der Ausatmung wieder zurück in Richtung Boden, lege sie aber dort nicht vollständig ab. Führe mit der nächsten Einatmung deinen Arm und dein Bein erneut über der Mitte deines Körpers zusammen.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-fitness-standard.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(20),
        leisureCategoryId: 1,
        name: 'Beinheben im Liegen',
        duration: const Duration(minutes: 5),
        descriptionShort:
            'Mache so viele Wiederholungen wie du schaffst.',
        descriptionLong: 
          const Value<String>('Die Ausgangsposition für das Beinheben im Liegen ist die Rückenlage, die Arme liegen während der Übung locker gestreckt parallel zum Körper auf der Matte. Die Beine liegen ebenfalls gestreckt und ungefähr hüftbreit auf. Drücke nun den Rücken in die Matte und spanne den Bauch an. Hebe dann beim Einatmen die Beine an, bis sie einen rechten Winkel mit dem Oberkörper bilden und die Zehenspitzen zur Decke zeigen. Senke die Beine mit der Ausatmung langsam und kontrolliert wieder zum Boden ab, ohne sie vollständig abzulegen.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-fitness-standard.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(21),
        leisureCategoryId: 1,
        name: 'Eseltritte (Donkey Kicks)',
        duration: const Duration(minutes: 5),
        descriptionShort:
            'Mache so viele Wiederholungen wie du schaffst.',
        descriptionLong: 
          const Value<String>('Ausgangsposition ist der Vierfüßlerstand. Hebe nun das linke Bein an, bis dein Oberschenkel in Verlängerung des Rumpfes gerade nach hinten heraus ragt. Dein Unterschenkel ist angewinkelt, der Winkel zwischen Ober- und Unterschenkel beträgt etwas mehr als 90 Grad, die Fußsohle zeigt zur Decke. Kicke jetzt mit der linken Fußsohle ca. 8 Mal nach oben in Richtung Decke. Bewege dann Dein Bein in die Startposition zurück und wiederhole die Übung mit dem anderen Bein.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-fitness-standard.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(22),
        leisureCategoryId: 1,
        name: 'Hampelmann (Jumping Jack)',
        duration: const Duration(minutes: 5),
        descriptionShort:
            'Mache so viele Wiederholungen wie du schaffst.',
        descriptionLong: 
          const Value<String>('Nimm die Grundstellung ein: Der Abstand zwischen Deinen Fußinnenseiten beträgt nur wenige Zentimeter, Deine Fußspitzen zeigen nach vorne. Die Knie sind locker und nicht vollständig durchgestreckt. Die Arme hängen entspannt links und rechts neben dem Körper, die Handflächen liegen locker auf den Oberschenkeln auf. Verlagere Dein Gewicht auf den Vorderfuß und spring vom Boden ab. Spreize dabei Deine Beine seitlich. Deine Füße setzen etwas breiter als schulterbreit kurz am Boden auf, bevor Du in die Ausgangsposition zurück springst. Gleichzeitig mit dem Abspreizen der Beine hebst Du Deine Arme seitlich und führst sie fast vollständig durchgestreckt nach oben. Wenn Deine Beine gespreizt am Boden aufsetzen, berühren sich die Fingerspitzen über dem Kopf. Führe nun die Arme wieder nach unten zurück, während Du mit den Füßen in die Ausgangsstellung zurückspringst. Wiederhole die Übung in fließenden Bewegungen.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-fitness-standard.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(23),
        leisureCategoryId: 1,
        name: 'Knieheben im Stand',
        duration: const Duration(minutes: 5),
        descriptionShort:
            'Mache so viele Wiederholungen wie du schaffst.',
        descriptionLong: 
          const Value<String>('Grundstellung ist der Ausfallschritt. Die Arme liegen locker an den Seiten an. Bringe nun Spannung auf den Rumpf, balle Deine Hände zu festen Fäusten. Heb das Knie des hinteren Beins nach vorne an, bis sich der Oberschenkel des gebeugten Beins in einer parallelen Position zum Boden befindet. Gleichzeitig ziehst Du den Arm auf der gleichen Körperseite nach hinten zurück und führst den diagonalen Arm mit Schwung nach vorne oben bis auf Kopfhöhe.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-fitness-knee-lift.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(24),
        leisureCategoryId: 1,
        name: 'Ausfallschritt nach vorne',
        duration: const Duration(minutes: 5),
        descriptionShort:
            'Mache so viele Wiederholungen wie du schaffst.',
        descriptionLong: 
          const Value<String>('Stell Dich schulterbreit auf und stütze die Hände locker knapp oberhalb der Hüfte ab. Spanne die gesamte Rumpf-Muskulatur an. Mach mit dem rechten Bein einen großen Schritt nach vorne und beuge gleichzeitig das linke Knie in Richtung Boden, so dass Du nur noch mit der Spitze des linken Fußes den Boden berührst. Drücke Dich aus dieser Position wieder nach oben in die Ausgangsstellung und wiederhole die Übung mit dem anderen Bein.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-fitness-big-step.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(25),
        leisureCategoryId: 1,
        name: 'Beckenheben (Brücke)',
        duration: const Duration(minutes: 5),
        descriptionShort:
            'Mache so viele Wiederholungen wie du schaffst.',
        descriptionLong: 
          const Value<String>('Lege Dich bequem mit dem Rücken auf die Matte. Die Arme liegen locker links und rechts parallel zum Körper auf der Matte, die Knie sind angewinkelt, die Füße stehen etwa hüftbreit nebeneinander. Nun spannst Du Bauch-, Rücken- und Po-Muskulatur fest an und hebst Deinen Po vom Boden ab, bis Oberkörper und Oberschenkel eine gerade Linie bilden. Halte diese Position einen Augenblick und senke das Becken dann wieder auf die Matte ab.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-fitness-standard.svg'),
      ),
      /**************************************************************************************************/
      // Yoga & Meditation
      LeisureActivitiesCompanion.insert(
        id: const Value(26),
        leisureCategoryId: 2,
        name: '5min Meditation',
        duration: const Duration(minutes: 5),
        descriptionShort:
            'Meditiere für eine kurze Zeit.',
        descriptionLong: 
          const Value<String>('Setze dich gemütlich in. Schließe die Augen. Versuche an nichts zu denken. Höre nur deinem Atem zu. Wenn Gedanken kommen, dann nehme sie wahr aber gehe nicht genau auf sie ein und lasse sie weiter ziehen.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-yoga-meditation.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(27),
        leisureCategoryId: 2,
        name: '20min Meditation',
        duration: const Duration(minutes: 20),
        descriptionShort:
            'Meditiere etwas länger und entspanne dich.',
        descriptionLong: 
          const Value<String>('Setze dich gemütlich in. Schließe die Augen. Versuche an nichts zu denken. Höre nur deinem Atem zu. Wenn Gedanken kommen, dann nehme sie wahr aber gehe nicht genau auf sie ein und lasse sie weiter ziehen.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-yoga-meditation.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(28),
        leisureCategoryId: 2,
        name: 'Ausfallschritt mit T-Rotation (dynamisches Dehnen)',
        duration: const Duration(minutes: 5),
        descriptionShort:
            'Bewege dich langsam und bewusst mit deinem Atem. Halte die Übung eine Weile.',
        descriptionLong: 
          const Value<String>('Stell Dich schulterbreit auf und spann die gesamte Rumpf-Muskulatur an. Mach dann mit dem rechten Bein einen großen Ausfallschritt nach vorne, so dass das hintere Bein fast gestreckt ist. Stütze Dich jetzt mit der linken Hand auf Höhe des vorderen Fußes auf dem Boden ab. Winkle den rechten Arm an und bringe den Ellbogen in Richtung Boden. Drehe dann Deinen Oberkörper nach rechts und strecke den Arm in Richtung Decke hoch. Dein Blick folgt dabei den Fingerspitzen. Bewege Dich nun in umgekehrter Reihenfolge aus dieser Position wieder in die Ausgangsstellung zurück und wiederhole die Übung auf der anderen Körperseite in gleicher Weise.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-yoga-standard.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(29),
        leisureCategoryId: 2,
        name: 'Das Boot (rückenschonende Variante)',
        duration: const Duration(minutes: 5),
        descriptionShort:
            'Bewege dich langsam und bewusst mit deinem Atem. Halte die Übung eine Weile.',
        descriptionLong: 
          const Value<String>('Hebe aus der liegenden Position deine gestreckten Beine an, bis sie ungefähr einen 45° Winkel mit dem Boden bilden. Außerdem hebst du nun Kopf und Schulterblätter an. Der untere Rücken bleibt aber auf dem Boden. Die Arme streckst du in Richtung Knie, die Ellenbogen-Gelenke sind nicht ganz durchgestreckt.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-yoga-standard.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(30),
        leisureCategoryId: 2,
        name: 'Den unteren Rücken dehnen (Krokodil)',
        duration: const Duration(minutes: 5),
        descriptionShort:
            'Bewege dich langsam und bewusst mit deinem Atem. Halte die Übung eine Weile.',
        descriptionLong: 
          const Value<String>('Lege dich bequem auf den Rücken, stelle deine Füße mit angewinkelten Knie auf die Matte. Deine Arme liegen T-förmig links und rechts auf dem Boden. Lege dann deine Beine bzw. Knie nach links auf den Boden ab und drehe deinen Kopf gleichzeitig zur rechten Seite. Versuche dabei, die Schulterblätter nicht abzuheben. Atme tief in die Dehnung hinein und halte die Position für einige Sekunden bevor du auf die andere Seite wechselst.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-yoga-standard.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(31),
        leisureCategoryId: 2,
        name: 'Der Yoga Baum',
        duration: const Duration(minutes: 5),
        descriptionShort:
            'Bewege dich langsam und bewusst mit deinem Atem. Halte die Übung eine Weile.',
        descriptionLong: 
          const Value<String>('Stelle Dich gerade hin. Du kannst den Baum in verschiedenen Varianten ausführen: Variante 1: Stelle die linke Ferse auf deinen rechten Fuß. Die Zehen des linken Fußes haben noch Bodenkontakt. Variante 2: Platziere Deine linke Fußsohle leicht unterhalb des rechten Knies. Du stehst jetzt komplett auf einem Bein. Drehe Dein linkes Knie nach außen und öffne Deine Hüfte. Variante 3: Platziere Deine linke Fußsohle auf der Innenseite Deines rechten Oberschenkels. Versuche nun, einen sicheren Stand zu finden. Dabei hilft es, die Muskulatur in den Beinen, Bauch und Rumpf zu aktivieren. Führe dann Deine Hände vor der Brunst ins Namaste zusammen. Als Steigerung kannst du die Hände anschließend über Deinen Köpf führen. Dann senkst du das Bein langsam wieder ab und setzt den Fuß auf dem Boden auf. Wiederhole die Übung mit dem anderen Bein.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-yoga-standard.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(32),
        leisureCategoryId: 2,
        name: 'Herabschauender Hund',
        duration: const Duration(minutes: 5),
        descriptionShort:
            'Bewege dich langsam und bewusst mit deinem Atem. Halte die Übung eine Weile.',
        descriptionLong: 
          const Value<String>('Aus dem hüftbreiten Stand beugst Du Deinen Rücken Wirbel für Wirbel langsam und gleichmäßig vornüber, bis Deine Fingerspitzen den Boden berühren. Auf Fingerspitzen wanderst Du dann ein Stück nach vorne, bis Oberkörper und Oberschenkel einen Winkel von etwa 90° bilden. Setze die ganze Hand mit gespreizten Fingern auf dem Boden auf, mach Deinen Rücken lang, indem Du Deinen Po nach hinten oben herausschiebst und versuche dabei die Fersen in den Boden zu drücken. Stabilisiere Dich in der Position und atme gleichmäßig weiter. Als kleine Variation kannst du abwechselnd die rechte und die linke Ferse vom Boden abheben. Wandere schließlich auf den Fingerspitzen wieder zurück in eine aufrechte Position.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-yoga-standard.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(33),
        leisureCategoryId: 2,
        name: 'Katze - Kuh',
        duration: const Duration(minutes: 5),
        descriptionShort:
            'Bewege dich langsam und bewusst mit deinem Atem. Halte die Übung eine Weile.',
        descriptionLong: 
          const Value<String>('In der Ausgangsposition stehst du im Vierfüßlerstand auf der Matte. Für die erste Position ziehst du deinen Bauchnabel ein und kippst dein Becken. Deine Wirbelsäule bewegt sich jetzt in Richtung Decke wie der Rücken einer Katze. Das Kinn zeigt zur Brust. Mit dem nächsten Einatmen senkst du deinen Bauch in Richtung Boden und ziehst deine Schulterblätter nach hinten. Gleichzeitig hebst du den Kopf, so dass der Blick nach vorne geht. Dein Rücken sieht jetzt ein bisschen aus wie der leicht durchgebeugte Rücken einer Kuh. Wechsle einige Male zwischen der Katze- und Kuh-Stellung.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-yoga-standard.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(34),
        leisureCategoryId: 2,
        name: 'Rücken dehnen aus dem Vierfüßlerstand',
        duration: const Duration(minutes: 5),
        descriptionShort:
            'Bewege dich langsam und bewusst mit deinem Atem. Halte die Übung eine Weile.',
        descriptionLong: 
          const Value<String>('Aus dem Vierfüßlerstand schiebst du deine Arme fast vollständig durchgestreckt weit nach vorne. Lass deinen Oberkörper nach unten durchhängen, bis du eine Dehnung im gesamten Rücken sowie in den Schultern verspürst. Bleib für ca. 15 Sekunden in dieser Haltung. Lege eine kurze Pause ein und wiederhole die Übung dann so oft du möchtest. Versuche mit jedem Mal die Dehnung ein klein wenig zu intensivieren.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-yoga-standard.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(35),
        leisureCategoryId: 2,
        name: 'Rückenschaukel',
        duration: const Duration(minutes: 5),
        descriptionShort:
            'Bewege dich langsam und bewusst mit deinem Atem. Halte die Übung eine Weile.',
        descriptionLong: 
          const Value<String>('Deine Ausgangsstellung ist eine sitzende Position mit angewinkelten Knie und angezogenen Beinen. Deine Hände umfassen dabei jeweils das rechte und linke Bein am Unterschenkel knapp unterhalb der Kniegelenke. Aus der Ausgangsstellung rollst Du sachte auf der Matte nach hinten auf den Rücken ab, bis Deine Schultern beinahe den Boden berühren. Kurz bevor Deine Schultern auf der Matte zu liegen kommen, bremst Du in der Bewegung ab und schaukelst mit Deinem gesamten Körper wieder zurück fast bis in die Ausgangsstellung. Du tippst vorne kurz mit den Zehenspitzen auf und lässt Dich dann in einer Schaukelbewegung wieder nach hinten zurückfallen.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-yoga-standard.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(36),
        leisureCategoryId: 2,
        name: 'Rumpfdrehen in der Vorbeuge (Windmühle)',
        duration: const Duration(minutes: 5),
        descriptionShort:
            'Bewege dich langsam und bewusst mit deinem Atem. Halte die Übung eine Weile.',
        descriptionLong: 
          const Value<String>('Stelle dich in einem gegrätschten Stand stabil auf, die Zehenspitzen zeigen leicht nach außen. Bring Spannung auf Rücken, Bauch und Po und beuge deinen Oberkörper im Zeitlupentempo nach vorne unten, so dass du mit deinen Handflächen oder den Fingerspitzen den Boden berührst. Strecke nun einen Arm in Richtung Himmel, bis beide Arme schließlich eine senkrechte Linie bilden. Dein Kopf dreht sich mit, indem du deinem Arm hinterher schaust. Bewege dich zurück in die Ausgangsposition und führe die Übung seitenverkehrt durch.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-yoga-windmill.svg'),
      ),
      /**************************************************************************************************/
      // Outdoor & Bewegung
      LeisureActivitiesCompanion.insert(
        id: const Value(37),
        leisureCategoryId: 3,
        name: 'Spaziergang',
        duration: const Duration(minutes: 15),
        descriptionShort:
            'Mache einen kurzen Spaziergang.',
        descriptionLong: 
          const Value<String>('Gehe raus an die frische Luft und bewege dich ein bisschen. Achte Bewusst auf deine Umwelt und nimm die kleinen Dinge wahr. Wie der Wind durch deine Haare streift, wie die Wolken heute aussehen und mehr. Atme tief durch!'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-outdoor-walk.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(38),
        leisureCategoryId: 3,
        name: 'Schreien',
        duration: const Duration(minutes: 20),
        descriptionShort:
            'Suche dir einen abgelegenen Ort und schreie so laut du kannst!',
        descriptionLong: 
          const Value<String>('Manchmal tut es sehr gut, einfach zu schreien! Gehe dafür an einen abgelegenen Ort, an dem dich keiner hören kann. Nun schreie so laut du kannst und so oft du willst. Denke dabei an alles was dich belastet, aufregt oder runterzieht und lass es gehen! Befreiend oder?'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-outdoor-walk.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(39),
        leisureCategoryId: 3,
        name: 'Joggen lang',
        duration: const Duration(minutes: 60),
        descriptionShort:
            'Gehe eine lange Runde joggen.',
        descriptionLong: 
          const Value<String>('Jogge für eine Stunde in deiner Geschwindigkeit.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-outdoor-jogging.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(40),
        leisureCategoryId: 3,
        name: 'Joggen kurz',
        duration: const Duration(minutes: 30),
        descriptionShort:
            'Gehe eine kurze Runde joggen.',
        descriptionLong: 
          const Value<String>('Jogge für eine halbe Stunde in deiner Geschwindigkeit.'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-outdoor-jogging.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(41),
        leisureCategoryId: 3,
        name: 'Mache ein Natur Foto',
        duration: const Duration(minutes: 10),
        descriptionShort:
            'Fange einen schönen Moment ein.',
        descriptionLong: 
          const Value<String>('Gehe raus vor die Tür und suche nach dem perfekten Foto. Dies kann ein Blatt sein oder ein Tier. Was auch immer dir positiv auffällt. Schieße ein Foto was dich glücklich macht!'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-outdoor-camera.svg'),
      ),
      /**************************************************************************************************/
      // Weitere Vorschläge
      LeisureActivitiesCompanion.insert(
        id: const Value(42),
        leisureCategoryId: 4,
        name: 'Malen',
        duration: const Duration(minutes: 15),
        descriptionShort:
            'Male ein Motiv deiner Wahl.',
        descriptionLong: 
          const Value<String>('Schnappe dir einen Zeichenblock oder eine Leinwand und sei kreativ!'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-other-paint.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(43),
        leisureCategoryId: 4,
        name: 'Musik machen',
        duration: const Duration(minutes: 15),
        descriptionShort:
            'Übe ein Instrument.',
        descriptionLong: 
          const Value<String>('Du spielst ein Instrument? Prima, dann ist das die perfekte Gelegenheit mal wieder ein bisschen zu üben!'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-other-music.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(44),
        leisureCategoryId: 4,
        name: 'Singen',
        duration: const Duration(minutes: 15),
        descriptionShort:
            'Singe ein paar Songs.',
        descriptionLong: 
          const Value<String>('Suche dir ein paar Lieder deiner Wahl heraus und singe mit!'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-other-singing.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(45),
        leisureCategoryId: 4,
        name: 'Lerne eine neue Sprache',
        duration: const Duration(minutes: 15),
        descriptionShort:
            'Lerne eine neue Sprache deiner Wahl',
        descriptionLong: 
          const Value<String>('Du wolltest schon immer mal diese eine neue Sprache lernen? Prima, dann ist dies jetzt die richtige Gelegenheit dafür!'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-other-new-language.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(46),
        leisureCategoryId: 4,
        name: 'Lerne ein neues Instrument',
        duration: const Duration(minutes: 15),
        descriptionShort:
            'Lerne etwas neues!',
        descriptionLong: 
          const Value<String>('Du wolltest schon immer dieses eine Instrument spielen können? Prima! Dann ist jetzt die richtige Gelegenheit dafür!'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-other-new-instrument.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(47),
        leisureCategoryId: 4,
        name: 'Koche ein neues Gericht',
        duration: const Duration(minutes: 60),
        descriptionShort:
            'Probiere neue Rezepte!',
        descriptionLong: 
          const Value<String>('Immer das selbe ist langweilig! Probiere mal etwas neues aus!'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-other-cooking-baking.svg'),
      ),
      LeisureActivitiesCompanion.insert(
        id: const Value(48),
        leisureCategoryId: 4,
        name: 'Backe ein neues Rezept',
        duration: const Duration(minutes: 60),
        descriptionShort:
            'Probiere neue Rezepte!',
        descriptionLong: 
          const Value<String>('Immer das selbe ist langweilig! Probiere mal etwas neues aus!'),
        isFavorite: false,
        pathToImage: const Value<String>('assets/leisure/leisure-other-cooking-baking.svg'),
      ),
    ]);
  });
}
