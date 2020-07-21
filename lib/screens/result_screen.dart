import 'package:app/widgets/scrabble_rose.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/game.dart';
import '../widgets/scrabble_net.dart';
import '../widgets/user_result_tile.dart';

class ResultScreen extends StatelessWidget {
  static const routeName = "/results";
  static const alignments = {
    1: Alignment.topCenter,
    2: Alignment.centerLeft,
    3: Alignment.centerRight,
    4: Alignment.bottomCenter,
  };
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text("Wyniki"),
      leading: const CloseButton(),
    );
    var players = Provider.of<Game>(context).players;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: appBar,
      body: Stack(
        children: <Widget>[
          Center(
            child: ScrabbleNet(),
          ),
          Center(
            child: ScrabbleRose(),
          ),
          Center(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: MediaQuery.of(context).size.width),
              child: Stack(children: <Widget>[
                for (var i = 0; i < players.length; i++)
                  Align(
                      alignment: alignments[i + 1],
                      child: UserResultTile(players[i], i + 1)),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
