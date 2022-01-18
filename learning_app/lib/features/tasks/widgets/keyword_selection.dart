import 'package:flutter/material.dart';
import 'package:learning_app/features/keywords/dtos/read_key_word_dto.dart';
import 'package:learning_app/features/tasks/widgets/keyword_input_field.dart';

class KeywordSelection extends StatefulWidget {
  final Function onSelect;
  final List<ReadKeyWordDto> selectedKeywords;
  final List<ReadKeyWordDto> options;

  const KeywordSelection({
    Key? key,
    required this.onSelect,
    required this.selectedKeywords,
    required this.options,
  }) : super(key: key);

  @override
  _KeywordSelectionState createState() => _KeywordSelectionState();
}

class _KeywordSelectionState extends State<KeywordSelection> {
  List<ReadKeyWordDto> selectedKeyWords = [];

  @override
  void initState() {
    super.initState();
    selectedKeyWords = widget.selectedKeywords;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KeyWordInputField(
          onSelect: (List<ReadKeyWordDto> selected) {
            // Update local state and emit newly selected keywords
            setState(() {
              selectedKeyWords = selected;
            });

            widget.onSelect(
              selected,
            );
          },
          preselectedKeywords: selectedKeyWords,
          options: widget.options,
        ),
        const SizedBox(height: 10.0),
        Wrap(
          direction: Axis.horizontal,
          runSpacing: 7.5,
          spacing: 7.5,
          children: selectedKeyWords.map((e) {
            return Chip(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                label: Text(e.name),
                deleteIcon: const Icon(
                  Icons.close,
                ),
                onDeleted: () {
                  var newKeyWords =
                      selectedKeyWords.where((k) => k.id != e.id).toList();

                  setState(() {
                    selectedKeyWords = newKeyWords;
                  });

                  widget.onSelect(
                    newKeyWords,
                  );
                });
          }).toList(),
        )
      ],
    );
  }
}
