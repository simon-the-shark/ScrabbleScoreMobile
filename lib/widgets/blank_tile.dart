import 'package:flutter/material.dart';

import 'scrabble_tile.dart';

class BlankTile extends StatelessWidget {
  BlankTile({this.letter});
  final String letter;
  @override
  Widget build(BuildContext context) {
    return ScrabbleTile(
      letter: letter == null ? "" : "($letter)",
      points: 0,
    );
  }
}
