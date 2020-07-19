import 'package:flutter/material.dart';

import 'scrabble_tile.dart';

class BlankTile extends StatelessWidget {
  BlankTile({this.letter, this.tileIndex});
  final String letter;
  final int tileIndex;
  @override
  Widget build(BuildContext context) {
    return ScrabbleTile(
      letter: letter == null ? "" : "($letter)",
      points: 0,
      tileIndex: tileIndex,
    );
  }
}
