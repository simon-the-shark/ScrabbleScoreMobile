import 'package:app/screens/game_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../helpers/scrabble_helper.dart';
import '../providers/games.dart';
import '../widgets/my_custom_icons_icons.dart';
import '../widgets/podium_box.dart';
import 'result_screen.dart';

class HistoryScreen extends StatefulWidget {
  static const routeName = "/history";

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<int> selected = [];
  Games gameRef;
  Widget buildBody() {
    var provider = Provider.of<Games>(context);
    if (provider.games.isEmpty)
      return Center(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          "Twoje rozgrywki będą widoczne tutaj!",
          softWrap: true,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline4,
        ),
      ));
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var game in provider.games)
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              color: selected.contains(game["id"])
                  ? Theme.of(context).primaryColorLight
                  : ScrabbleHelper.DIRTY_WHITE,
              child: ListTile(
                onTap: selected.isEmpty
                    ? game['finished'] == 1
                        ? () {
                            setState(() {
                              selected.clear();
                            });
                            Navigator.of(context).pushNamed(
                                ResultScreen.routeName,
                                arguments: game);
                          }
                        : () {
                            setState(() {
                              selected.clear();
                            });
                            Navigator.of(context).pushNamed(
                                GameMenuScreen.routeName,
                                arguments: game);
                          }
                    : () {
                        setState(() {
                          if (!selected.contains(game["id"]))
                            selected.add(game["id"]);
                          else
                            selected.remove(game["id"]);
                        });
                      },
                onLongPress: () {
                  setState(() {
                    if (!selected.contains(game["id"]))
                      selected.add(game["id"]);
                    else
                      selected.remove(game["id"]);
                  });
                },
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

  @override
  void didChangeDependencies() {
    gameRef = Provider.of<Games>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    Future.delayed(Duration.zero, gameRef?.clearGames);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historia rozgrywek"),
        leading: selected.isEmpty
            ? IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    selected = [];
                  });
                },
              )
            : null,
        actions: [
          if (selected.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => Provider.of<Games>(context, listen: false)
                  .delete(selected)
                  .then((value) => setState(() {
                        selected = [];
                      })),
            ),
        ],
      ),
      body: !Provider.of<Games>(context).isReady
          ? FutureBuilder(
              future: Provider.of<Games>(context, listen: false).fetch(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return const Center(child: CircularProgressIndicator());
                print(snapshot.error);
                if (snapshot.hasError)
                  return Center(
                    child: FittedBox(
                      child: Text(
                        "Błąd wczytywania historii",
                        style: TextStyle(color: Theme.of(context).errorColor),
                      ),
                    ),
                  );
                return buildBody();
              },
            )
          : buildBody(),
    );
  }
}
