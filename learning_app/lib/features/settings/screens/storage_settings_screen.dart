import 'package:flutter/material.dart';
import 'package:learning_app/constants/settings_spacer.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/shared/open_confirm_dialog.dart';
import 'package:learning_app/shared/widgets/go_back_title_bar.dart';
import 'package:learning_app/shared/widgets/screen_without_bottom_navbar_base_template.dart';
import 'package:learning_app/util/storage_services.dart';
import 'package:restart_app/restart_app.dart';

class StorageSettingsScreen extends StatelessWidget {
  const StorageSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWithoutBottomNavbarBaseTemplate(
      titleBar: const GoBackTitleBar(
        title: "Speicher und Daten",
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
        children: [
          Text(
            "Hinweis:",
            style: Theme.of(context).textTheme.textStyle2.withBold,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Mit diesen Funktionen können einfach Backups des kompletten App"
            "zustands angelegt und wiederhergestellt werden.\n"
            "Zum Wiederherstellen ausgewählte Dateien werden derzeit nicht"
            " geprüft. Bitte wähle daher ausschließlich gültige Archive.",
            style: Theme.of(context).textTheme.settingsInfoTextStyle,
          ),
          spacer,
          OutlinedButton.icon(
            onPressed: () async {
              await exportStorageDialog(context);
            },
            label: const Text('Speicherstand exportieren'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.onBackgroundHard),
            ),
            icon: const Icon(Icons.file_download_outlined),
          ),
          OutlinedButton.icon(
            onPressed: () async {
              await importStorageDialog(context);
            },
            label: const Text('Speicherstand importieren'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.onBackgroundHard),
            ),
            icon: const Icon(Icons.file_upload_outlined),
          ),
          spacer,
        ],
      ),
    );
  }

  Future<void> exportStorageDialog(BuildContext context) async {
    bool success = await exportStorage();

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Die Anwendungsdaten wurden erfolgreich gesichert.',
          style: Theme.of(context).textTheme.textStyle2.withSucess,
          maxLines: 3,
        ),
        backgroundColor: Theme.of(context).colorScheme.subtleBackgroundGrey,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Bitte ein gültiges Verzeichnis auswählen.',
          style: Theme.of(context).textTheme.textStyle2.withError,
          maxLines: 3,
        ),
        backgroundColor: Theme.of(context).colorScheme.subtleBackgroundGrey,
      ));
    }
  }

  Future<void> importStorageDialog(BuildContext context) async {
    bool confirmImport = await openConfirmDialog(
      context: context,
      title: "Alle Daten überschreiben?",
      content: RichText(
        text: TextSpan(
          // Note: Styles for TextSpans must be explicitly defined.
          // Child text spans will inherit styles from parent
          style: Theme.of(context).textTheme.textStyle2,
          children: const <TextSpan>[
            TextSpan(
                text:
                    'Möchtest du wirklich einen vorhandenen Speicherstand importieren?'
                    'Alle aktuellen Anwendungsdaten gehen dadurch verloren!'),
          ],
        ),
      ),
      confirmButtonText: 'Ja',
      cancelButtonText: 'Nein',
    );

    if (!confirmImport) {
      // cancel
      return;
    }

    final success = await importStorage();

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Das Verzeichnis konnte nicht importiert werden.',
          style: Theme.of(context).textTheme.textStyle2.withError,
          maxLines: 3,
        ),
        backgroundColor: Theme.of(context).colorScheme.subtleBackgroundGrey,
      ));
      return;
    }

    // inform the user and activate new location by reloading everything
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Speicherstand erfolgreich importiert.\n'
          'Die App wird neugestartet, um die '
          'Änderungen anzuwenden',
          style: Theme.of(context).textTheme.textStyle2.withSucess,
          maxLines: 3,
        ),
        backgroundColor: Theme.of(context).colorScheme.subtleBackgroundGrey,
      ),
    );

    await Future.delayed(const Duration(seconds: 3));

    Restart.restartApp();
  }
}
