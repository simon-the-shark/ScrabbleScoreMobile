import 'package:flutter/material.dart';

import '../helpers/locator.dart';
import '../helpers/scrabble_helper.dart';
import '../screens/word_screen.dart';
import 'multpliers_dialog.dart';

class ScrabbleTile extends StatelessWidget {
  ScrabbleTile({this.letter, this.points, this.tileIndex});
  final String letter;
  final int points;
  final int tileIndex;

  final wordScreenKey = locator<GlobalKey<WordScreenState>>();

  @override
  Widget build(BuildContext context) {
    var multiplier =
        wordScreenKey?.currentState?.multipliers[tileIndex] ?? Multipliers.none;
    return GestureDetector(
      onTap: () {
        wordScreenKey?.currentState?.hideKeyboard();
        showDialog(
          context: context,
          child: MultipliersDialog(
            letter,
            tileIndex,
          ),
        );
      },
      child: SizedBox(
        height: 60,
        width: 60,
        child: Card(
          color: multiplier.color,
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 3,
                right: 3,
                child: Text(points.toString(),
                    style: ScrabbleHelper.textStyle.copyWith(fontSize: 15)),
              ),
              if (multiplier.type == MultipliersType.letter)
                Positioned(
                  bottom: 3,
                  left: 3,
                  child: Text("x${multiplier.value}",
                      style: ScrabbleHelper.textStyle.copyWith(fontSize: 11)),
                ),
              Center(
                child: Text(letter, style: ScrabbleHelper.textStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
