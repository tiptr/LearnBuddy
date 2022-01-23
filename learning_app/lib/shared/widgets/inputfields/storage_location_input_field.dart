import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/util/logger.dart';

class StorageLocationInputField extends StatefulWidget {
  final Future<bool> Function(String?) onChange;
  final String label;
  final String? preselectedLocation;
  final TextEditingController? textEditingController;

  const StorageLocationInputField({
    Key? key,
    required this.onChange,
    required this.preselectedLocation,
    required this.label,
    this.textEditingController,
  }) : super(key: key);

  @override
  State<StorageLocationInputField> createState() =>
      _StorageLocationInputFieldState();
}

class _StorageLocationInputFieldState extends State<StorageLocationInputField> {
  late final TextEditingController _textEditingController;
  late String? location;

  @override
  void initState() {
    super.initState();
    _textEditingController =
        widget.textEditingController ?? TextEditingController();
    location = widget.preselectedLocation;
    _textEditingController.text = location ?? '';

    // This listener is used for disallowing text selection
    _textEditingController.addListener(() {
      _textEditingController.selection =
          const TextSelection.collapsed(offset: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () async {
        // Unfocus, so that no keyboard will be opened for the textfield
        FocusManager.instance.primaryFocus?.unfocus();

        String? selectedDirectory =
            await FilePicker.platform.getDirectoryPath();

        if (selectedDirectory == null) {
          // User canceled the picker
          logger.d('Folder selection canceled by the user');
          return;
        }
        logger.d('Selected folder: $selectedDirectory');

        // Notify Listener and check, if the change is supposed to be applied:
        bool confirmed = await widget.onChange(selectedDirectory);

        if (confirmed) {
          // Change the text content
          _textEditingController.text = selectedDirectory;
          // Change the state, so the widget will re-render
          setState(() {
            location = selectedDirectory;
          });
        }
      },
      // The following attributes are used for disallowing text selection
      mouseCursor: null,
      showCursor: false,
      toolbarOptions: const ToolbarOptions(), // empty -> no toolbar
      readOnly: true,
      maxLines: null,
      controller: _textEditingController,
      style: Theme.of(context).textTheme.textStyle2,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onBackground,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2.0,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: false,
        prefixIcon: Icon(
          Icons.sd_storage_outlined,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        suffixIcon: location != null
            ? IconButton(
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                onPressed: () async {
                  // Notify Listener and check, if the change is supposed to be applied:
                  bool confirmed = await widget.onChange(null);

                  if (confirmed) {
                    // Change the text content
                    _textEditingController.text = '';
                    // Change the state, so the widget will re-render
                    setState(() {
                      location = null;
                    });
                  }
                },
              )
            : null,
        label: Text(
          widget.label,
          style: Theme.of(context).textTheme.textStyle2.withBold,
        ),
        hintText: 'Geschützter Standardspeicherort',
        hintStyle:
            // Same TextStyle with a softer color. Inherited from the textfield,
            // so the TextStyle is not explicitly defined with a constant
            TextStyle(color: Theme.of(context).colorScheme.onBackgroundSoft),
      ),
    );
  }
}
