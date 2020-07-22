import 'package:flutter/material.dart';

import 'history_screen.dart';
import 'users_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ScrabbleScore Mobile"),
        ),
        body: Center(
          child: SizedBox(
            width: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(flex: 4),
                RaisedButton(
                  child: const Text("Nowa gra"),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(UsersScreen.routeName),
                ),
                const Spacer(flex: 1),
                RaisedButton(
                  color: Colors.deepPurple,
                  child: const Text("Historia"),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(HistoryScreen.routeName),
                ),
                const Spacer(flex: 4),
              ],
            ),
          ),
        ));
  }
}
