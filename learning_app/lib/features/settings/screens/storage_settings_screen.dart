import 'package:flutter/material.dart';
import 'package:learning_app/constants/settings_spacer.dart';
import 'package:learning_app/constants/storage_constants.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/shared/open_confirm_dialog.dart';
import 'package:learning_app/shared/shared_preferences_data.dart';
import 'package:learning_app/shared/widgets/go_back_title_bar.dart';
import 'package:learning_app/shared/widgets/inputfields/storage_location_input_field.dart';
import 'package:learning_app/shared/widgets/screen_without_bottom_navbar_base_template.dart';
import 'package:learning_app/util/logger.dart';
import 'package:learning_app/util/storage_services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
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
            "Um einen benutzerdefinierten Speicherort der Appdaten nutzen zu können,"
            " muss je nach Betriebsystem die Berechtigung für den Zugriff erlaubt werden.\n"
            "Ein benutzerdefinierter Ort ermöglicht den manuellen Zugriff auf die Daten, um"
            " beispielsweise Backups anzulegen.\n"
            "Bestehende Anwendungsdaten werden beim Wechsel des Ortes nicht ungefragt überschrieben.",
            style: Theme.of(context).textTheme.settingsInfoTextStyle,
          ),
          spacer,
          StorageLocationInputField(
            onChange: (String? newLocation) async {
              return await _changeStorageLocation(newLocation, context);
            },
            label: 'Alternativer Speicherort der Anwendungsdaten',
            preselectedLocation: SharedPreferencesData.isCustomStorageLocation
                ? SharedPreferencesData.storageLocation
                : null,
          ),
          spacer,
        ],
      ),
    );
  }

  Future<bool> _changeStorageLocation(
      String? newCustomLocation, BuildContext context) async {
    final String currentLocation = SharedPreferencesData.storageLocation;
    final String newLocation = newCustomLocation ??
        join((await getApplicationDocumentsDirectory()).path,
            defaultDirectorySubFolderName);

    if (currentLocation == newLocation) {
      // nothing to do
      return false;
    }

    if (newCustomLocation == null) {
      // The protected default folder is selected to be re-used
      // Ask the user, if he wants to continue
      bool useDefaultLocation = await openConfirmDialog(
        context: context,
        title: "Standardspeicherort verwenden?",
        content: RichText(
          text: TextSpan(
            // Note: Styles for TextSpans must be explicitly defined.
            // Child text spans will inherit styles from parent
            style: Theme.of(context).textTheme.textStyle2,
            children: const <TextSpan>[
              TextSpan(
                  text: 'Möchtest du den Speicherstand zurück in das'
                      'geschützte Standardverzeichnis der App verschieben?'),
            ],
          ),
        ),
        confirmButtonText: 'Ja',
        cancelButtonText: 'Nein',
      );

      if (useDefaultLocation) {
        moveContentToNewDirectory(
            oldPath: currentLocation, newPath: newLocation);
      } else {
        //cancel
        return false;
      }
    } else if (isFolderEmpty(newLocation)) {
      // A custom folder is selected, which is empty
      // simply move the content and use the new folder
      moveContentToNewDirectory(oldPath: currentLocation, newPath: newLocation);
    } else if (doesContainDatabase(newLocation)) {
      // two databases exist -> let the user decide which to keep (or cancel)
      bool useNewLocation = await openConfirmDialog(
        context: context,
        title: "Speicherstand überschreiben?",
        content: RichText(
          text: TextSpan(
            // Note: Styles for TextSpans must be explicitly defined.
            // Child text spans will inherit styles from parent
            style: Theme.of(context).textTheme.textStyle2,
            children: const <TextSpan>[
              TextSpan(
                  text: 'In dem ausgewählten Verzeichnis befindet sich'
                      'bereits ein Speicherstand der Anwendung.\n'
                      'Möchtest du zu diesem Speicherstand wechseln?'),
            ],
          ),
        ),
        confirmButtonText: 'Ja',
        cancelButtonText: 'Nein',
      );
      logger.d('$useNewLocation');

      if (useNewLocation) {
        // Existing storage in new location will be used
        // Ask whether to delete the old storage
        bool keepOldStorage = await openConfirmDialog(
          context: context,
          title: "Alten Speicherstand behalten?",
          content: RichText(
            text: TextSpan(
              // Note: Styles for TextSpans must be explicitly defined.
              // Child text spans will inherit styles from parent
              style: Theme.of(context).textTheme.textStyle2,
              children: const <TextSpan>[
                TextSpan(
                    text:
                        'Du hast ausgewählt, den existierenden Speicherzustand'
                        ' im neuen Verzeichnis verwenden zu wollen.\n'
                        'Möchtest du den aktuell geöffneten Speicherzustand löschen?\n'
                        'Wenn du "Ja" wählst, kannst du einfach zu dem Zustand zurückwechseln.'),
              ],
            ),
          ),
          confirmButtonText: 'Ja',
          cancelButtonText: 'Nein',
        );

        if (!keepOldStorage) {
          deleteDirectoryContent(currentLocation);
        }
      } else {
        // Existing storage in new location will NOT be used
        // Ask whether to override it with the current data or cancel
        bool deleteExistingFiles = await openConfirmDialog(
          context: context,
          title: "Ordner überschreiben?",
          content: RichText(
            text: TextSpan(
              // Note: Styles for TextSpans must be explicitly defined.
              // Child text spans will inherit styles from parent
              style: Theme.of(context).textTheme.textStyle2,
              children: const <TextSpan>[
                TextSpan(
                    text:
                        'Du hast ausgewählt, den aktuell geöffneten Speicherzustand'
                        ' weiterhin verwenden zu wollen.\n'
                        'Möchtest du den anderen im gewählten Ordner bereits vorhandenen'
                        ' Speicherzustand löschen und überschreiben?\n'
                        'Wenn du "Nein" wählst, wird der Vorgang abgebrochen.'),
              ],
            ),
          ),
          confirmButtonText: 'Ja',
          cancelButtonText: 'Nein',
        );

        if (deleteExistingFiles) {
          // delete the existing files in the new directory
          deleteDirectoryContent(newLocation);
          // move to the new directory
          moveContentToNewDirectory(
              oldPath: currentLocation, newPath: newLocation);
        } else {
          // cancel everything
          return false;
        }
      }
    } else {
      // new location does contain files, but the content is not a valid
      // existing app database -> notify user and cancel
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Bitte einen leeren Ordner, oder einen\n'
            'existierenden Speicherstand auswählen.',
            style: Theme.of(context).textTheme.textStyle2.withError,
            maxLines: 2,
          ),
          backgroundColor: Theme.of(context).colorScheme.subtleBackgroundGrey,
        ),
      );
      return false;
    }

    // save new location
    await SharedPreferencesData.storeCustomStorageLocation(newCustomLocation);
    // inform the user and activate new location by reloading everything
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Neuer Speicherort ausgewählt.\n'
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

    return true;
  }
}
