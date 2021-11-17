# SoftwareEngineering-WS2022-Unicorns

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

## Linksammlung:

**Figma-Mockups (öffentlich)**

[FörderBot Präsenation](https://www.figma.com/proto/Ko0Gm8JhHINOPG75DsksQU/F%C3%B6rderBot?node-id=35%3A1550&scaling=min-zoom&page-id=0%3A1&starting-point-node-id=35%3A1550)

[EasyMemo Präsentation](https://www.figma.com/proto/pUthVnZu7BPOC1ifNEHEIv/EasyMemo?node-id=38%3A258&scaling=min-zoom&page-id=0%3A1&starting-point-node-id=38%3A258)

[LearnBuddy Präsentation](https://www.figma.com/proto/SiypR268Dp8208XULJcgg5/LearnBuddy?node-id=318%3A3&scaling=min-zoom&page-id=0%3A1&starting-point-node-id=318%3A3)

**Figma-Mockups (nicht öffentlich)**

[Figma Gruppe](https://www.figma.com/files/project/42233173/Prototypen?fuid=910427524644309056)

[FörderBot](https://www.figma.com/file/Ko0Gm8JhHINOPG75DsksQU/F%C3%B6rderBot)

[EasyMemo](https://www.figma.com/file/pUthVnZu7BPOC1ifNEHEIv/EasyMemo)

[LearnBuddy](https://www.figma.com/file/SiypR268Dp8208XULJcgg5/LearnBuddy)

**Weitere interne Links (nicht öffentlich)**

[Miro-Board (Understand, Observe, Define, Ideate)](https://miro.com/app/board/o9J_lobuOqY=/?invite_link_id=427245118953) 