import 'dart:math';

import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_custom.dart';

import '../helpers/locator.dart';
import '../helpers/scrabble_helper.dart';
import 'cursor.dart';
import 'scrabble_tile.dart';
import 'user_widget.dart';

class UserFinalInput extends StatelessWidget {
  UserFinalInput(this.number, this.name, {this.notifier, this.focusNode});

  final int number;
  final String name;
  final ValueNotifier<String> notifier;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      color: ScrabbleHelper.DIRTY_WHITE,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        title: KeyboardCustomInput<String>(
          focusNode: focusNode,
          height: 110,
          notifier: notifier,
          builder: (context, val, hasFocus) {
            var chars = val.split("");
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    name,
                    style: ScrabbleHelper.textStyle
                        .copyWith(color: UserWidget.colors[number]),
                  ),
                  LayoutBuilder(builder: (context, constrains) {
                    var width =
                        min((constrains.maxWidth - 2) / 7, (60.0 - 2 / 7));
                    var borderColor =
                        hasFocus ? UserWidget.colors[number] : Colors.white;
                    return Container(
                      width: min(constrains.maxWidth, 60.0 * 7),
                      decoration: BoxDecoration(
                        color: chars.length > 0 ? Colors.white : null,
                        border: chars.length == 0
                            ? Border(bottom: BorderSide(color: borderColor))
                            : Border.all(color: borderColor),
                      ),
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: <Widget>[
                          if (chars.length == 0)
                            Text("  Wprowadź niewykorzystane płytki",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black38)),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              if (chars.length == 0) Container(height: width),
                              for (var char in chars)
                                ScrabbleTile(
                                  sideSize: width,
                                  letter: char,
                                  points: ScrabbleHelper.LETTERS[char],
                                  smallFontSize: 11,
                                  textStyle: ScrabbleHelper.textStyle
                                      .copyWith(fontSize: 15),
                                ),
                              if (hasFocus && chars.length < 7)
                                Cursor(
                                    key: newCursorKey(),
                                    color: UserWidget.colors[number],
                                    height: width - 13),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }
}
