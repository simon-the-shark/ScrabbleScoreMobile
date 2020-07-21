import 'package:app/screens/final_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/game.dart';
import '../widgets/user_widget.dart';

class GameMenuScreen extends StatelessWidget {
  static const routeName = "/game/menu";
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text("ScrabbleScore Mobile"),
      leading: const CloseButton(),
    );
    var players = Provider.of<Game>(context).players;
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Column(children: <Widget>[
          Spacer(flex: 3),
          Text(
            "Wybierz gracza, aby doliczyć punkty",
            style: Theme.of(context).textTheme.headline6,
            softWrap: true,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          for (var player in players) UserWidget(player),
          Spacer(flex: 4),
          RaisedButton(
            child: const Text("Zakończ rozgrywkę"),
            onPressed: () =>
                Navigator.of(context).pushNamed(FinalScreen.routeName),
          ),
          Spacer(flex: 2),
        ]),
      ),
    );
  }
}
