import 'package:app/helpers/scrabble_helper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ScrabbleScoreMobile"),
      ),
      body: Wrap(
        children: <Widget>[...ScrabbleHelper.scrabbleTiles],
      ),
    );
  }
}
