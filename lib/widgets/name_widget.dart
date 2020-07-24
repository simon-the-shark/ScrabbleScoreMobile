import 'dart:math';

import 'package:flutter/material.dart';

import '../helpers/scrabble_helper.dart';
import 'logo.dart';
import 'scrabble_tile.dart';

class NameWidget extends StatelessWidget {
  const NameWidget();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            var logo = 60;
            var width = constraints.maxWidth;
            width -= logo;
            var itemWidth = min((width / 6) - 5, 50.0);
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Logo(),
                for (var letter in ["R", "A", "B", "B", "L", "E"])
                  ScrabbleTile(
                    letter: letter,
                    points: ScrabbleHelper.LETTERS[letter],
                    sideSize: itemWidth,
                    smallFontSize: 13,
                    textStyle: ScrabbleHelper.textStyle.copyWith(fontSize: 16),
                  ),
              ],
            );
          },
        ),
        LayoutBuilder(builder: (context, constraints) {
          var logo = 60;
          var width = constraints.maxWidth;
          width -= logo;
          var itemWidth = min((width / 6) - 6, 50.0);
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var letter in ["S", "C", "O", "R", "E"])
                ScrabbleTile(
                  letter: letter,
                  points: ScrabbleHelper.LETTERS[letter],
                  sideSize: itemWidth,
                  smallFontSize: 12,
                  textStyle: ScrabbleHelper.textStyle.copyWith(fontSize: 15),
                ),
            ],
          );
        }),
      ],
    );
  }
}
