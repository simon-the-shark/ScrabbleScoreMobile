import 'package:flutter/material.dart';

class ScrabbleNet extends StatelessWidget {
  static const net = [
    [
      [0, 1, 1, 0],
      [0, 1, 1, 1],
      [0, 0, 1, 1]
    ],
    [
      [1, 1, 1, 0],
      [1, 1, 1, 1],
      [1, 0, 1, 1]
    ],
    [
      [1, 1, 0, 0],
      [1, 1, 0, 1],
      [1, 0, 0, 1]
    ],
  ];
  @override
  Widget build(BuildContext context) {
    var side = (MediaQuery.of(context).size.width / 3) - 2;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (var c = 0; c < 3; c++)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (var r = 0; r < 3; r++)
                Container(
                  height: side,
                  width: side,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border(
                      top: net[r][c][0].toDouble() == 1
                          ? const BorderSide(width: 1)
                          : BorderSide.none,
                      right: net[r][c][1].toDouble() == 1
                          ? const BorderSide(width: 1)
                          : BorderSide.none,
                      bottom: net[r][c][2].toDouble() == 1
                          ? const BorderSide(width: 1)
                          : BorderSide.none,
                      left: net[r][c][3].toDouble() == 1
                          ? const BorderSide(width: 1)
                          : BorderSide.none,
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}
