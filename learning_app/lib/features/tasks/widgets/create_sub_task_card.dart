import 'package:flutter/material.dart';
import 'package:learning_app/constants/card_elevation.dart';

const double iconSize = 14.0;

const double verticalPaddingCardContentSubTasks = 2;

const double distanceBetweenCardsSubTasks = 7.0;

/// The card used inside the tasks detail screen for the quick creation of new
/// subtasks
class CreateSubTaskCard extends StatefulWidget {
  const CreateSubTaskCard({Key? key}) : super(key: key);

  @override
  State<CreateSubTaskCard> createState() => _CreateSubTaskCardState();
}

class _CreateSubTaskCardState extends State<CreateSubTaskCard> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
      elevation: CardElevation.high,
      child: Container(
        padding: const EdgeInsets.only(
          top: 10.0,
          bottom: 10.0,
          right: 10.0,
          left: 10.0,
        ),
        height: 75.0,
        child: Expanded(
          flex: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // TODO: cancel button
              // Checkbox
              Transform.scale(
                scale: 1.3,
                child: IconButton(
                    onPressed: () {
                      // TODO
                    },
                    icon: const Icon(Icons.cancel_outlined)),
              ),

              // Left Row: title input
              _buildTitleInputTextField(context),
              const SizedBox(width: 10.0), // min distance
              // TODO: confirm button?
              Transform.scale(
                scale: 1.3,
                child: IconButton(
                    onPressed: () {
                      // TODO
                    },
                    icon: const Icon(
                      Icons.add_task_outlined,
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
        style: const TextStyle(
            color: Color(0xFF636573), fontWeight: FontWeight.normal),
        decoration: const InputDecoration(
          filled: false,
          hintText: 'Name der Unteraufgabe',
          hintStyle: TextStyle(color: Color(0xFF949597)),
        ),
        maxLines: null, // no limit
        controller: _textEditingController,
        // onChanged: widget.onChange, // TODO
      ),
    );
  }
}
