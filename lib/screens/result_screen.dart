import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/scrabble_helper.dart';
import '../providers/game.dart';
import '../widgets/podium_box.dart';
import '../widgets/user_widget.dart';

class ResultScreen extends StatefulWidget {
  static const routeName = "/results";

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    AutoOrientation.landscapeAutoMode();
    super.initState();
  }

  @override
  void dispose() {
    AutoOrientation.fullAutoMode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text("Wyniki"),
      leading: const CloseButton(),
    );
    var players = Provider.of<Game>(context).players;
    var height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        appBar.preferredSize.height;
    var width = MediaQuery.of(context).size.width * 0.75;
    var platform = <Widget>[
      for (var i = 0; i < players.length; i++)
        SizedBox(
          width: width / 4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FittedBox(
                child: Text(
                  players[i].value,
                  style: ScrabbleHelper.textStyle.copyWith(
                    color: UserWidget.colors[players[i].key],
                  ),
                ),
              ),
              Text(
                Provider.of<Game>(context).points[players[i].key].toString(),
                style: ScrabbleHelper.textStyle.copyWith(
                  color: UserWidget.colors[players[i].key],
                  fontSize: 35,
                ),
              ),
              PodiumBox(height, width, i + 1),
            ],
          ),
        )
    ];
    return Scaffold(
      appBar: appBar,
      body: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: platform..replaceRange(0, 2, [platform[1], platform[0]]),
        ),
      ),
    );
  }
}
