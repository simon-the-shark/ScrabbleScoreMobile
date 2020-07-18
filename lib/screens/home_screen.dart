import 'package:app/helpers/scrabble_helper.dart';
import 'package:app/screens/users_screen.dart';
import 'package:flutter/material.dart';

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
