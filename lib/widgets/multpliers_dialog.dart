import 'package:easy_dialogs/single_choice_confirmation_dialog.dart';
import 'package:flutter/material.dart';

import '../helpers/locator.dart';
import '../helpers/scrabble_helper.dart';
import '../screens/word_screen.dart';

class MultipliersDialog extends StatelessWidget {
  MultipliersDialog(this.letter, this.tileIndex);
  final String letter;
  final int tileIndex;
  @override
  Widget build(BuildContext context) {
    var wordScreenKey = locator<GlobalKey<WordScreenState>>();
    var initial =
        wordScreenKey?.currentState?.multipliers[tileIndex] ?? Multipliers.none;
    return SingleChoiceConfirmationDialog<String>(
      title: Text('Premia pod płytką $letter'),
      initialValue: initial.name,
      items: Multipliers.values.map((e) => e.name).toList(),
      onSubmitted: (value) => wordScreenKey?.currentState?.addMultiplier(
        tileIndex,
        Multipliers.values.firstWhere((element) => element.name == value),
      ),
    );
  }
}
