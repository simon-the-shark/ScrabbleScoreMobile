import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text_provider.dart';

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
    Map args = ModalRoute.of(context).settings.arguments;
    int points;
    if (args == null) {
      points = Provider.of<Game>(context).points[player.key];
    } else {
      points = args["player${player.key}"];
    }
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      color: ScrabbleHelper.DIRTY_WHITE,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) =>
                ChangeNotifierProvider<SpeechToTextProvider>.value(
              value: locator<SpeechToTextProvider>(),
              child: WordScreen(player.key, key: newWordScreenKey()),
            ),
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
            points.toString(),
            style: ScrabbleHelper.textStyle
                .copyWith(color: UserWidget.colors[player.key], fontSize: 30),
          ),
        ),
      ),
    );
  }
}
