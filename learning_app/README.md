# learning_app

## Setup Guide

Um Flutter zu installieren, folgt man am einfachsten der [Dokumentation](https://docs.flutter.dev/get-started/install).

Unter Windows kann dieses Bash-Script aus einer administrativen Shell vereinfachend verwendet werden:

```bash
# cd into the directory where you want flutter to be installed
git clone https://github.com/flutter/flutter.git -b stable
cd flutter/bin/
setx PATH "%PATH%;%cd%"
flutter
```

Jetzt muss für Windows [Android Studio](https://developer.android.com/studio) mit dem Android Virtual Device Emulator bzw. für Mac [XCode](https://developer.apple.com/xcode/) installiert werden. In Android Studio muss auf `Customize ⟶ All Settings ⟶ Plugins` nun noch das `Flutter`-Plugin installiert werden. Außerdem sollten unter `Customize ⟶ All Settings ⟶ Appearance & Behavior ⟶ System Settings ⟶ Android SDK ⟶ SDK Tools` die Punkte **Android SDK Command line Tools**, **Android Emulator** und **Android SDK Platform-Tools** aktiviert sein. Mit dem Befehl `flutter doctor` kann die Installation geprüft und etwaige Fehler erkannt werden.

In Android Studio kann jetzt im [Android Device Emulator](https://docs.flutter.dev/get-started/install/windows#set-up-the-android-emulator) ein virtuelles Gerät für die Entwicklung erstellt werden. Für dieses Projekt wurde im Setup **Android 11** gewählt.

In [Visual Studio Code](https://code.visualstudio.com/) kann nun die Extension [Flutter](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter) heruntergeladen werden. Jetzt sollte es in Visual Studio Code rechts unten möglich sein, ein virtuelles Gerät für die Entwicklung auszuwählen. Ist das Gerät gestartet, kann die App mit `flutter run` bzw. F5 in VS Code auf dem virtuellen Endgerät geladen werden. Dies benötigt bei der ersten Ausführung einige Minuten. 
