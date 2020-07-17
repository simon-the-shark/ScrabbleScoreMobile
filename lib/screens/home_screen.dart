import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ScrabbleScoreMobile"),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: const Text("Nowa gra"),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
