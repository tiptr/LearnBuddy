import 'package:flutter/material.dart';
import 'package:learning_app/constants/basic_card.dart';

const double iconSize = 14.0;

const double verticalPaddingCardContentSubTasks = 2;

const double distanceBetweenCardsSubTasks = 7.0;

/// The card used inside the tasks detail screen for the quick creation of new
/// subtasks
class CreateSubTaskCard extends StatefulWidget {
  final Function(String) onPressEnterSubmit;
  final Function(String) onUseButtonSubmit;
  final Function onDiscard;

  const CreateSubTaskCard({
    Key? key,
    required this.onPressEnterSubmit,
    required this.onUseButtonSubmit,
    required this.onDiscard,
  }) : super(key: key);

  @override
  State<CreateSubTaskCard> createState() => _CreateSubTaskCardState();
}

class _CreateSubTaskCardState extends State<CreateSubTaskCard> {
  final TextEditingController _textEditingController = TextEditingController();
  bool titleEmpty = true;

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      // Toggle titleEmpty
      if (_textEditingController.text.isNotEmpty && titleEmpty) {
        setState(() {
          titleEmpty = false;
        });
      } else if (_textEditingController.text.isEmpty && !titleEmpty) {
        setState(() {
          titleEmpty = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(vertical: distanceBetweenCardsSubTasks),
      child: _card(context),
    );
  }

  Widget _card(BuildContext context) {
    const borderRadius = 12.5;

    return Card(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      color: Theme.of(context).cardColor,
      elevation: BasicCard.elevation.high,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 3.0,
        ),
        height: 75.0,
        child: Expanded(
          flex: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Cancel button
              Transform.scale(
                scale: 1.3,
                child: IconButton(
                    onPressed: () {
                      widget.onDiscard();
                    },
                    icon: const Icon(
                      Icons.cancel_outlined,
                      color: Color(0xFF40424A),
                    )),
              ),
              const SizedBox(width: 5.0), // min distance
              // Title input
              _buildTitleInputTextField(context),
              const SizedBox(width: 5.0), // min distance
              // Confirm button
              Transform.scale(
                scale: 1.3,
                child: IconButton(
                    onPressed: () {
                      if (!titleEmpty) {
                        widget.onUseButtonSubmit(_textEditingController.text);
                      }
                    },
                    icon: Icon(
                      Icons.add_task_outlined,
                      color: titleEmpty
                          ? const Color(0xFF949597)
                          : const Color(0xFF40424A),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleInputTextField(BuildContext context) {
    return Expanded(
      flex: 80,
      child: TextField(
        autofocus: true,
        maxLines: 1,
        style: const TextStyle(
            color: Color(0xFF40424A), fontWeight: FontWeight.normal),
        decoration: const InputDecoration(
          filled: false,
          hintText: 'Name der Unteraufgabe',
          hintStyle: TextStyle(color: Color(0xFF949597)),
          border: InputBorder.none,
        ),
        controller: _textEditingController,
        onSubmitted: (text) {
          widget.onPressEnterSubmit(text);
        },
      ),
    );
  }
}
