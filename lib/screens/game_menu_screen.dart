import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/game.dart';
import '../widgets/user_widget.dart';
import 'final_screen.dart';

class GameMenuScreen extends StatelessWidget {
  static const routeName = "/game/menu";
  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    var interactive = args == null;
    int id;
    List<MapEntry<int, String>> players;
    if (interactive) {
      players = Provider.of<Game>(context).players;
    } else {
      players = [
        MapEntry(1, args["player1Name"]),
        MapEntry(2, args["player2Name"]),
        if (args["player3Name"] != null) MapEntry(3, args["player3Name"]),
        if (args["player4Name"] != null) MapEntry(4, args["player4Name"]),
      ]..sort(
          (a, b) => args["player${b.key}"].compareTo(args["player${a.key}"]));
      id = args['id'];
    }
    final appBar = AppBar(
      title: interactive
          ? const Text("ScrabbleScore Mobile")
          : Text("Rozgrywka #$id"),
      leading: const CloseButton(),
    );
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
                    if (interactive)
                      Text(
                        "Wybierz gracza, aby doliczyć punkty",
                        style: Theme.of(context).textTheme.headline6,
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    const SizedBox(height: 15),
                    for (var player in players)
                      IgnorePointer(
                          ignoring: !interactive, child: UserWidget(player)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: 190,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (interactive)
                          RaisedButton(
                            child: const Text("Cofnij ruch"),
                            color: Colors.yellow[300],
                            onPressed: Provider.of<Game>(context, listen: false)
                                    .canReverse
                                ? () async {
                                    var confirmation = await showDialog(
                                        context: context,
                                        child: AlertDialog(
                                          title: const Text("Cofnięcie ruchu"),
                                          content: const Text(
                                              "Czy chcesz cofnąć ostatni ruch?"),
                                          actions: [
                                            FlatButton(
                                                onPressed:
                                                    Navigator.of(context).pop,
                                                child: const Text("Nie")),
                                            FlatButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(true),
                                                child: const Text("Cofnij")),
                                          ],
                                        ));
                                    if (confirmation == true)
                                      Provider.of<Game>(context, listen: false)
                                          .reverseLastMove();
                                  }
                                : null,
                          ),
                        const SizedBox(height: 5),
                        if (interactive)
                          RaisedButton(
                            child: const Text("Zakończ rozgrywkę"),
                            onPressed: () => Navigator.of(context)
                                .pushNamed(FinalScreen.routeName),
                          ),
                        if (!interactive)
                          SizedBox(
                            height: 43,
                            child: RaisedButton.icon(
                              icon: const Icon(Icons.play_arrow),
                              label: const Text("Wznów grę"),
                              onPressed: () {
                                Provider.of<Game>(context, listen: false)
                                    .loadGame(args);
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    GameMenuScreen.routeName,
                                    (route) => route.isFirst);
                              },
                              color: Colors.purple,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 1),
              ]),
        ),
      ),
    );
  }
}
