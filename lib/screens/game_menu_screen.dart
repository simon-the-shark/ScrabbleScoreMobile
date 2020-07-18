import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/game.dart';
import '../widgets/user_widget.dart';

class GameMenuScreen extends StatelessWidget {
  static const routeName = "/game/menu";
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text("ScrabbleScoreMobile"),
      leading: const CloseButton(),
      actions: <Widget>[
        // IconButton(
        //   icon: Icon(Icons.remove),
        //   onPressed: () {},
        // ),
        // IconButton(
        //   icon: const Text(
        //     "+50",
        //     style: TextStyle(fontSize: 17),
        //   ),
        //   onPressed: () {},
        // ),
      ],
    );
    var players = Provider.of<Game>(context).players;
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Column(children: <Widget>[
          Spacer(flex: 3),
          for (var player in players) UserWidget(player),
          Spacer(flex: 4),
          RaisedButton(
            child: const Text("Zakończ rozgrywkę"),
            onPressed: () {},
          ),
          Spacer(flex: 2),
        ]),
      ),
    );
  }
}
