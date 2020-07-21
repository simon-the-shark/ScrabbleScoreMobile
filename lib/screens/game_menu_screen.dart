import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/game.dart';
import '../widgets/user_widget.dart';
import 'final_screen.dart';

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
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            maxWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                appBar.preferredSize.height,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const SizedBox(height: 15),
                    Text(
                      "Wybierz gracza, aby doliczyć punkty",
                      style: Theme.of(context).textTheme.headline6,
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    for (var player in players) UserWidget(player),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: RaisedButton(
                    child: const Text("Zakończ rozgrywkę"),
                    onPressed: () =>
                        Navigator.of(context).pushNamed(FinalScreen.routeName),
                  ),
                ),
                const SizedBox(height: 1),
              ]),
        ),
      ),
    );
  }
}
