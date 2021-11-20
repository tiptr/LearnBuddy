# learning_app

## Setup Guide

#### Flutter
Um Flutter zu installieren, folgt man am einfachsten der [Dokumentation](https://docs.flutter.dev/get-started/install).

**Windows**
Unter Windows kann dieses Bash-Script aus einer administrativen Shell vereinfachend verwendet werden:

```bash
# cd into the directory where you want flutter to be installed
git clone https://github.com/flutter/flutter.git -b stable
cd flutter/bin/
setx PATH "%PATH%;%cd%"
flutter
```

**Linux**
Unter Arch-basierten Distributionen wird Flutter über AUR angeboten: [AUR flutter](https://aur.archlinux.org/packages/flutter/).
Im Anschluss `flutter doctor` ausführen, um die Installation zu beenden.
Dabei kann es auftreten, dass der Nutzer keine Berechtigungen auf das Installationverzeichnis hat. In diesem Fall müssen die Rechte des Verzeichnisses manuell angepasst werden.
Alternativ kann flutter manuell installiert werden (siehe [Dokumentation](https://docs.flutter.dev/get-started/install/linux)).


#### IDE

**Android Studio**
Jetzt muss für Linux / Windows [Android Studio](https://developer.android.com/studio) mit dem Android Virtual Device Emulator installiert werden (z.B. als One-Click Installation über die [Jetbrains Toolbox](https://www.jetbrains.com/de-de/toolbox-app/)).

In Android Studio muss auf `Customize ⟶ All Settings ⟶ Plugins` nun noch das `Flutter`-Plugin installiert werden. 
Außerdem sollten unter `Customize ⟶ All Settings ⟶ Appearance & Behavior ⟶ System Settings ⟶ Android SDK ⟶ SDK Tools` die Punkte **Android SDK Command line Tools**, **Android Emulator** und **Android SDK Platform-Tools** aktiviert sein. 
Mit dem Befehl `flutter doctor` kann die Installation geprüft und etwaige Fehler erkannt werden.

In Android Studio kann jetzt im [Android Device Emulator](https://docs.flutter.dev/get-started/install/windows#set-up-the-android-emulator) ein virtuelles Gerät für die Entwicklung erstellt werden. Für dieses Projekt wurde im Setup **Android 11** bzw **Android 12** (inkl. Google APIs) gewählt.

Als Projekt kann das komplette Repository oder das App-Verzeichnis 'learning_app' geöffnet werden.
Falls angezeigt wird, dass keine Dart-Konfiguration vorliegt, dies ignorieren und unter `Settings -> Languages & Frameworks -> Flutter` den `Flutter SDK path` entsprechend der Installation eintragen.
Daraufhin wird Dart automatisch erkann.

Unter `Edit Configurations` kann nun eine Run-Konfigration eingerichtet werden: Dafür über `+` eine Konfiguration mit der `Flutter` Vorlage erstellen und `\learning_app\lib\main.dart` als Dart Entrypoint auswählen. Auch der Debugging-Modus sollte damit bereits funktionieren.

Um den Emulator direkt in das IDE-Fenster zu integrieren, kann `Settings -> Tools -> Emulator -> Launch in a tool window` aktiviert werden.

**XCode**
Für Mac kann auch XCode eingesetzt werden: [XCode](https://developer.apple.com/xcode/) [Flutter documentation](https://docs.flutter.dev/get-started/install/macos).

**Visual Studio Code**

Zunächst der Anleitung für Android Studio folgen, um den Android Device Emulator zu installieren.

In [Visual Studio Code](https://code.visualstudio.com/) kann nun die Extension [Flutter](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter) heruntergeladen werden. Jetzt sollte es in Visual Studio Code rechts unten möglich sein, ein virtuelles Gerät für die Entwicklung auszuwählen. Ist das Gerät gestartet, kann die App mit `flutter run` bzw. F5 in VS Code auf dem virtuellen Endgerät geladen werden. Dies benötigt bei der ersten Ausführung einige Minuten. 
