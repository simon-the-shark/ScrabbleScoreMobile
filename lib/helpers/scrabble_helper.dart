import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScrabbleHelper {
  static const DIRTY_WHITE = Color.fromRGBO(232, 228, 201, 1);
  static const LETTERS = {
    "A": 1,
    "Ą": 5,
    "B": 3,
    "C": 2,
    "Ć": 6,
    "D": 2,
    "E": 1,
    "Ę": 5,
    "F": 5,
    "G": 3,
    "H": 3,
    "I": 1,
    "J": 3,
    "K": 2,
    "L": 2,
    "Ł": 3,
    "M": 2,
    "N": 1,
    "Ń": 7,
    "O": 1,
    "Ó": 5,
    "P": 2,
    "R": 1,
    "S": 1,
    "Ś": 5,
    "T": 2,
    "U": 3,
    "W": 1,
    "Y": 2,
    "Z": 1,
    "Ź": 9,
    "Ż": 5,
    "": 0,
  };
  static final textStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.green[900],
  );
  static final scrabbleTiles = LETTERS.map((key, _) => MapEntry(
      key,
      SizedBox(
        height: 60,
        width: 60,
        child: Card(
          color: DIRTY_WHITE,
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 5,
                right: 5,
                child: Text(LETTERS[key].toString(),
                    style: textStyle.copyWith(fontSize: 15)),
              ),
              Center(
                child: Text(key, style: textStyle),
              ),
            ],
          ),
        ),
      )));

  static int calculateScore(List<String> word) {
    var score = 0;
    word.forEach((char) {
      var points = LETTERS[char];
      if (points != null) score += points;
    });
    return score;
  }
}
