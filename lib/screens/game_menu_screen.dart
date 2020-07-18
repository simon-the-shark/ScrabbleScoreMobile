import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/game.dart';
import '../widgets/user_widget.dart';

class GameMenuScreen extends StatelessWidget {
  static const routeName = "/game/menu";
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: const Text("ScrabbleScoreMobile"));
    var players = Provider.of<Game>(context).players;
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Column(children: <Widget>[
          for (var player in players.entries) UserWidget(player),
        ]),
      ),
    );
  }
}
