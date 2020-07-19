import 'package:app/helpers/scrabble_helper.dart';
import 'package:flutter/material.dart';

class ScrabbleTile extends StatelessWidget {
  ScrabbleTile({this.letter, this.points});
  final String letter;
  final int points;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: Card(
        color: ScrabbleHelper.DIRTY_WHITE,
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 5,
              right: 5,
              child: Text(points.toString(),
                  style: ScrabbleHelper.textStyle.copyWith(fontSize: 15)),
            ),
            Center(
              child: Text(letter, style: ScrabbleHelper.textStyle),
            ),
          ],
        ),
      ),
    );
  }
}
