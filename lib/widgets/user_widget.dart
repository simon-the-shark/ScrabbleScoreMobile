import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/locator.dart';
import '../helpers/scrabble_helper.dart';
import '../providers/game.dart';
import '../screens/word_screen.dart';

class UserWidget extends StatelessWidget {
  UserWidget(this.player);

  final MapEntry<int, String> player;

  static const colors = {
    1: Colors.green,
    2: Colors.orange,
    3: Colors.blue,
    4: Colors.pink,
  };
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      color: ScrabbleHelper.DIRTY_WHITE,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) =>
                WordScreen(player.key, key: newWordScreenKey()),
            settings: const RouteSettings(
              name: WordScreen.routeName,
            ),
          ),
        ),
        leading: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border:
                  Border.all(width: 1, color: UserWidget.colors[player.key])),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              player.key.toString(),
              style: ScrabbleHelper.textStyle
                  .copyWith(color: UserWidget.colors[player.key]),
            ),
          ),
        ),
        title: Text(player.value),
        trailing: Container(
          child: Text(
            Provider.of<Game>(context).points[player.key].toString(),
            style: ScrabbleHelper.textStyle
                .copyWith(color: UserWidget.colors[player.key], fontSize: 30),
          ),
        ),
      ),
    );
  }
}
