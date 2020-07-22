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
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text("Wyniki"),
      leading: const CloseButton(),
    );
    var players = Provider.of<Game>(context).players;
    double height;
    double width;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      height = MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top -
          appBar.preferredSize.height;
      width = MediaQuery.of(context).size.width * 0.75;
    } else {
      height = MediaQuery.of(context).size.width;
      width = height * 0.90;
    }
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
    if (platform.length == 2)
      platform.add(
        SizedBox(
          width: width / 4,
          child: PodiumBox(height, width, 3),
        ),
      );
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
