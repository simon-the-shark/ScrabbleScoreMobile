import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_custom.dart';

import '../helpers/locator.dart';
import '../helpers/scrabble_helper.dart';
import 'blank_lock_button.dart';
import 'keyboard_button.dart';

enum SpecialKeyboardButton { backspace, blankLock, enter }

class ScrabbleKeyboard extends StatelessWidget
    with KeyboardCustomPanelMixin<String>
    implements PreferredSizeWidget {
  final ValueNotifier<String> notifier;
  static const double _kKeyboardHeight = 200;

  ScrabbleKeyboard(
      {Key key, this.notifier, this.hideKeyboard, this.blankLock = true})
      : super(key: key);
  final Function hideKeyboard;
  final bool blankLock;
  static const ROWS = const [
    ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
    [
      "A",
      "S",
      "D",
      "F",
      "G",
      "H",
      "J",
      "K",
      "L",
      SpecialKeyboardButton.backspace
    ],
    [
      SpecialKeyboardButton.blankLock,
      "Z",
      "X",
      "C",
      "V",
      "B",
      "N",
      "M",
      SpecialKeyboardButton.enter
    ],
  ];

  static const SPECIAL_LETTERS = const {
    "E": "Ę",
    "O": "Ó",
    "A": "Ą",
    "S": "Ś",
    "L": "Ł",
    "Z": "Ż",
    "X": "Ź",
    "N": "Ń",
    "C": "Ć",
  };

  @override
  void updateValue(String value) {
    super.updateValue("");
    super.updateValue(value);
  }

  Widget buildBackspace(double width, double height) => KeyboardButton(
        width,
        height,
        onPressed: () => updateValue(null),
        child: Icon(
          Icons.backspace,
          color: ScrabbleHelper.darkGreen,
        ),
      );

  Widget buildEnter(width, height, {context}) => KeyboardButton(
        width,
        height,
        onPressed: hideKeyboard,
        child: Icon(
          Icons.subdirectory_arrow_left,
          color: ScrabbleHelper.darkGreen,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final rows = ROWS.length;
    final double screenWidth = MediaQuery.of(context).size.width;
    final int rowCount = ROWS[0].length;
    final double itemWidth = (screenWidth / rowCount);
    final double itemHeight = (_kKeyboardHeight / rows);
    final int lastRowSpecialCount = 2;
    final int lastRowCount = ROWS[2].length - lastRowSpecialCount;
    final double lastRowSpecialItemWidth =
        (screenWidth - (lastRowCount * itemWidth)) / lastRowSpecialCount;
    final specialButtons = {
      SpecialKeyboardButton.backspace: buildBackspace(itemWidth, itemHeight),
      SpecialKeyboardButton.blankLock: blankLock
          ? BlankLockButton(lastRowSpecialItemWidth, itemHeight, updateValue,
              key: newBlankLockKey())
          : KeyboardButton(
              lastRowSpecialItemWidth,
              itemHeight,
              onPressed: () => updateValue(" "),
              child: RotationTransition(
                turns: AlwaysStoppedAnimation(-15 / 360),
                child: Icon(Icons.check_box_outline_blank),
              ),
            ),
      SpecialKeyboardButton.enter:
          buildEnter(itemWidth, itemHeight, context: context),
    };
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: _kKeyboardHeight),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for (var row in ROWS)
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: row.map((button) {
                  if (button is String)
                    return KeyboardButton(
                      itemWidth,
                      itemHeight,
                      update: updateValue,
                      letter: button,
                    );
                  else
                    return specialButtons[button];
                }).toList(),
              ),
            )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_kKeyboardHeight);
}
