import 'package:app/providers/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/scrabble_helper.dart';

class WordScreen extends StatefulWidget {
  WordScreen(this.player);
  final int player;
  static const routeName = "/game/word";
  @override
  _WordScreenState createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
  final textNode = FocusNode();
  int score = 0;
  List<String> word = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Punkty: $score"),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Opacity(
            opacity: 0,
            child: TextField(
              focusNode: textNode,
              autofocus: true,
              onChanged: (value) => setState(() {
                word = value.toUpperCase().split("");
                score = ScrabbleHelper.calculateScore(word);
              }),
            ),
          ),
          Center(
            child: Wrap(
              children: <Widget>[
                for (var char in word)
                  ScrabbleHelper.scrabbleTiles[char] != null
                      ? ScrabbleHelper.scrabbleTiles[char]
                      : Container(width: 0, height: 0),
              ],
            ),
          ),
          if (word.length == 0)
            Center(
              child: Text(
                "Wpisz ułożone słowo",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontStyle: FontStyle.italic),
              ),
            ),
          GestureDetector(
            onTap: () => setState(() {
              if (textNode.hasFocus)
                textNode.unfocus();
              else
                textNode.requestFocus();
            }),
            child: SafeArea(
              child: Container(color: Colors.transparent),
            ),
          ),
          if (word.length != 0 && !textNode.hasFocus)
            Positioned(
              bottom: 60,
              child: RaisedButton(
                child: const Text("Dolicz słowo"),
                onPressed: () {
                  Provider.of<Game>(context, listen: false)
                      .addPoints(player: widget.player, points: score);
                  Navigator.of(context).pop();
                },
              ),
            )
        ],
      ),
    );
  }
}
