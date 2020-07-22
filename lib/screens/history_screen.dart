import 'package:app/screens/game_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../helpers/scrabble_helper.dart';
import '../providers/games.dart';
import '../widgets/my_custom_icons_icons.dart';
import '../widgets/podium_box.dart';
import 'result_screen.dart';

class HistoryScreen extends StatelessWidget {
  static const routeName = "/history";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historia rozgrywek"),
      ),
      body: FutureBuilder(
        future: Provider.of<Games>(context, listen: false).load(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return const Center(child: CircularProgressIndicator());
          else if (snapshot.hasError)
            return FittedBox(
              child: Text(
                "Błąd wczytywania historii",
                style: TextStyle(color: Theme.of(context).errorColor),
              ),
            );
          return HistoryBody();
        },
      ),
    );
  }
}

class HistoryBody extends StatelessWidget {
  const HistoryBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Games>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var game in provider.games)
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              color: ScrabbleHelper.DIRTY_WHITE,
              child: ListTile(
                onTap: game['finished'] == 1
                    ? () => Navigator.of(context)
                        .pushNamed(ResultScreen.routeName, arguments: game)
                    : () => Navigator.of(context)
                        .pushNamed(GameMenuScreen.routeName, arguments: game),
                leading: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 1, color: Colors.black54),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: FittedBox(
                      child: Text(
                        "#" +
                            game['id']
                                .toString()
                                .padLeft(provider.padding, "0"),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                    ),
                  ),
                ),
                title: Text(
                  DateFormat.yMMMd("pl_PL").format(
                    DateTime.fromMillisecondsSinceEpoch(
                      game["date"],
                    ),
                  ),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: game['finished'] == 1
                    ? Icon(
                        MyCustomIcons.trophy,
                        color: PodiumBox.placeColors[1],
                        size: 40,
                      )
                    : const Icon(
                        Icons.play_circle_outline,
                        color: Colors.purple,
                        size: 40,
                      ),
              ),
            ),
        ],
      ),
    );
  }
}
