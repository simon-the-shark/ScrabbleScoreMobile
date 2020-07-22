import 'package:flutter/material.dart';

import '../helpers/scrabble_helper.dart';
import 'my_custom_icons_icons.dart';

class PodiumBox extends StatelessWidget {
  PodiumBox(this.height, this.width, this.place);

  final int place;
  final double height;
  final double width;

  static const placeColors = const {
    1: const Color.fromRGBO(214, 175, 54, 1),
    2: const Color.fromRGBO(167, 167, 173, 1),
    3: const Color.fromRGBO(167, 112, 68, 1),
    4: ScrabbleHelper.DIRTY_WHITE,
  };
  static const placeHeightsFactors = const {
    1: 0.6,
    2: 0.4,
    3: 0.3,
    4: 0.1,
  };
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: placeHeightsFactors[place] * height,
      width: width / 4,
      child: Card(
        color: ScrabbleHelper.DIRTY_WHITE,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FittedBox(
            child: place == 1
                ? Icon(MyCustomIcons.trophy, color: placeColors[1])
                : place == 2
                    ? Icon(MyCustomIcons.medal, color: placeColors[2])
                    : place == 3
                        ? Icon(MyCustomIcons.medal, color: placeColors[3])
                        : Container(),
          ),
        ),
      ),
    );
  }
}
