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
                  child: SizedBox(
                    width: 190,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
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
                        RaisedButton(
                          child: const Text("Zakończ rozgrywkę"),
                          onPressed: () => Navigator.of(context)
                              .pushNamed(FinalScreen.routeName),
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
