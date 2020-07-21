import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/scrabble_helper.dart';
import '../providers/game.dart';
import 'my_custom_icons_icons.dart';

class UserResultTile extends StatelessWidget {
  UserResultTile(this.player, this.place);

  final MapEntry<int, String> player;
  final int place;
  static const colors = {
    1: Colors.green,
    2: Colors.orange,
    3: Colors.blue,
    4: Colors.pink,
  };
  static const placeColors = {
    1: Color.fromRGBO(214, 175, 54, 1),
    2: Color.fromRGBO(167, 167, 173, 1),
    3: Color.fromRGBO(167, 112, 68, 1),
    4: ScrabbleHelper.DIRTY_WHITE,
  };
  @override
  Widget build(BuildContext context) {
    var side = MediaQuery.of(context).size.width / 3;
    return SizedBox(
      height: side,
      width: side,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Card(
          color: ScrabbleHelper.DIRTY_WHITE,
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 3,
                right: 3,
                child: Text(
                    Provider.of<Game>(context).points[player.key].toString(),
                    style: ScrabbleHelper.textStyle.copyWith(
                        color: UserResultTile.colors[player.key],
                        fontSize: 35)),
              ),
              Center(
                child: FittedBox(
                  child: Text(player.value,
                      style: ScrabbleHelper.textStyle
                          .copyWith(color: UserResultTile.colors[player.key])),
                ),
              ),
              Positioned(
                bottom: 3,
                left: 3,
                child: place == 1
                    ? Icon(MyCustomIcons.trophy,
                        color: placeColors[1], size: 40)
                    : place == 2
                        ? Icon(MyCustomIcons.medal,
                            color: placeColors[2], size: 40)
                        : place == 3
                            ? Icon(MyCustomIcons.medal,
                                color: placeColors[3], size: 40)
                            : Container(
                                height: 0,
                                width: 0,
                              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
