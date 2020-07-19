import 'package:app/widgets/scrabble_keyboard.dart';

import '../helpers/scrabble_helper.dart';
import 'package:flutter/material.dart';

class KeyboardButton extends StatelessWidget {
  KeyboardButton(this.width, this.height,
      {this.onPressed, this.child, this.letter, this.update});
  final Widget child;
  final String letter;
  final Function onPressed;
  final Function update;
  final double width;
  final double height;
  static const buttonPadding =
      const EdgeInsets.symmetric(horizontal: 3, vertical: 5);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Padding(
        padding: buttonPadding,
        child: RaisedButton(
          padding: const EdgeInsets.all(0),
          color: ScrabbleHelper.DIRTY_WHITE,
          onPressed: letter != null && update != null
              ? () => update(letter)
              : onPressed,
          onLongPress: letter != null && update != null
              ? () => update(ScrabbleKeyboard.SPECIAL_LETTERS[letter])
              : null,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              if (letter != null &&
                  ScrabbleKeyboard.SPECIAL_LETTERS[letter] != null)
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Text(
                      ScrabbleKeyboard.SPECIAL_LETTERS[letter],
                      style: TextStyle(color: Colors.green[700], fontSize: 12),
                    ),
                  ),
                ),
              if (letter != null) Text(letter, style: ScrabbleHelper.textStyle),
              if (letter == null) child,
            ],
          ),
        ),
      ),
    );
  }
}
