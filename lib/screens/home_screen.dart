import 'package:flutter/material.dart';

import 'users_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ScrabbleScoreMobile"),
        ),
        body: Center(
          child: RaisedButton(
            child: const Text("Nowa gra"),
            onPressed: () =>
                Navigator.of(context).pushNamed(UsersScreen.routeName),
          ),
        ));
  }
}
