import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/keywords/bloc/keywords_cubit.dart';
import 'package:learning_app/features/keywords/dtos/read_key_word_dto.dart';
import 'package:learning_app/features/keywords/widgets/keyword_form_dialog.dart';
import 'package:learning_app/shared/open_confirm_dialog.dart';
import 'package:learning_app/util/logger.dart';

const double iconSize = 18.0;

class KeyWordCard extends StatelessWidget {
  final ReadKeyWordDto keyword;

  const KeyWordCard({Key? key, required this.keyword}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: _card(context),
    );
  }

  Widget _card(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.white,
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 70,
              child: Text(
                keyword.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Expanded(
              flex: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return KeyWordFormDialog(
                            existingKeyword: keyword,
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.create_outlined,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      var confirmed = await openConfirmDialog(
                        context: context,
                        title: "Schlagwort löschen?",
                        content: RichText(
                          text: TextSpan(
                            // Note: Styles for TextSpans must be explicitly defined.
                            // Child text spans will inherit styles from parent
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              const TextSpan(text: 'Willst du das Schlagwort '),
                              TextSpan(
                                text: keyword.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const TextSpan(text: ' wirklich löschen?'),
                            ],
                          ),
                        ),
                      );

                      if (confirmed) {
                        logger.d('Keyword ${keyword.name} wird gelöscht.');

                        BlocProvider.of<KeyWordsCubit>(context)
                            .deleteKeyWordById(keyword.id);
                      }
                    },
                    icon: Icon(
                      Icons.delete_outlined,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
