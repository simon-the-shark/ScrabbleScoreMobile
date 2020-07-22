import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/game.dart';
import '../providers/games.dart';
import '../screens/game_menu_screen.dart';

class ResumeButton extends StatelessWidget {
  const ResumeButton();
  @override
  Widget build(BuildContext context) {
    Provider.of<Game>(context);
    return FutureBuilder(
        future: Provider.of<Games>(context).fetchLastGame(),
        builder: (context, snapshot) {
          var disabled = snapshot.connectionState == ConnectionState.waiting ||
              snapshot.hasError ||
              !snapshot.hasData;
          return SizedBox(
            height: 43,
            child: RaisedButton.icon(
              icon: const Icon(Icons.play_arrow),
              label: const Text("Wznów grę"),
              onPressed: disabled
                  ? null
                  : () {
                      Provider.of<Game>(context, listen: false)
                          .loadGame(snapshot.data);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          GameMenuScreen.routeName, (route) => route.isFirst);
                    },
              color: Colors.purple,
            ),
          );
        });
  }
}
