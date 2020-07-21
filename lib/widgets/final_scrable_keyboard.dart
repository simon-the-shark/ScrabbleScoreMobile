import 'package:app/helpers/locator.dart';
import 'package:app/widgets/cursor.dart';
import 'package:flutter/material.dart';

import '../helpers/scrabble_helper.dart';
import 'scrabble_keyboard.dart';

class FinalScrabbleKeyboard extends ScrabbleKeyboard {
  FinalScrabbleKeyboard({Key key, notifier, hideKeyboard})
      : super(
          notifier: notifier,
          hideKeyboard: hideKeyboard,
          blankLock: false,
        );

  @override
  void updateValue(String value) {
    locator<GlobalKey<CursorState>>()?.currentState?.startTypying();
    var word = notifier.value.split("");
    if (value == null && word.length > 0)
      word.removeLast();
    else if (ScrabbleHelper.LETTERS.containsKey(value?.toUpperCase()) &&
        word.length < 7) word.add(value.toUpperCase());
    notifier.value = word.join("");
  }
}
