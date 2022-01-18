import 'package:flutter/material.dart';
import 'package:learning_app/features/keywords/dtos/read_key_word_dto.dart';

class KeywordSelectDialog extends StatefulWidget {
  final List<ReadKeyWordDto> preselectedOptions;
  final List<ReadKeyWordDto> options;

  const KeywordSelectDialog({
    Key? key,
    required this.preselectedOptions,
    required this.options,
  }) : super(key: key);

  @override
  State<KeywordSelectDialog> createState() => _KeywordSelectDialogState();
}

class _KeywordSelectDialogState extends State<KeywordSelectDialog> {
  final scrollController = ScrollController();
  List<ReadKeyWordDto> selectedOptions = [];

  @override
  void initState() {
    super.initState();

    selectedOptions = widget.preselectedOptions;
  }

  bool isSelected(int id) {
    return selectedOptions.map((e) => e.id).contains(id);
  }

  void toggleItem(ReadKeyWordDto keyWord) {
    setState(() {
      if (selectedOptions.contains(keyWord)) {
        selectedOptions =
            selectedOptions.where((e) => e.id != keyWord.id).toList();
      } else {
        selectedOptions = [...selectedOptions, keyWord];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300.0,
              width: 300.0,
              padding: const EdgeInsets.all(7.5),
              child: Scrollbar(
                isAlwaysShown: true,
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.5),
                  child: ListView.builder(
                    controller: scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: widget.options.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 4.0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Column(
                            children: <Widget>[
                              CheckboxListTile(
                                activeColor:
                                    Theme.of(context).colorScheme.primary,
                                dense: true,
                                title: Text(
                                  widget.options[index].name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  ),
                                ),
                                value: isSelected(widget.options[index].id),
                                onChanged: (bool? _) {
                                  toggleItem(widget.options[index]);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  child: const Text(
                    "Abbrechen",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(null);
                  },
                ),
                MaterialButton(
                  child: Text(
                    "Hinzufügen",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(selectedOptions);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
