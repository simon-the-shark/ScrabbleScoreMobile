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
    " ": 0,
  };
  static final darkGreen = Colors.green[900];
  static final textStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: darkGreen,
  );

  static int calculateScoreWithLetterMultipliers(
      List<String> word, Map<int, Multipliers> multipliers) {
    var score = 0;
    for (var i = 0; i < word.length; i++) {
      var char = word[i];
      if (i == 0 || word[i - 1] != "(") {
        var points = LETTERS[char];
        if (points != null) if ((multipliers[i]?.type ??
                MultipliersType.none) ==
            MultipliersType.letter)
          score += points * multipliers[i].value;
        else
          score += points;
      }
    }
    return score;
  }
}

enum Multipliers { none, x2Letter, x3Letter, x2Word, x3Word }
enum MultipliersType { letter, word, none }

extension MultipliersExtension on Multipliers {
  String get name {
    switch (this) {
      case Multipliers.x2Letter:
        return 'Podwójna premia literowa';
      case Multipliers.x3Letter:
        return 'Potrójna premia literowa';
      case Multipliers.x2Word:
        return 'Podwójna premia słowna';
      case Multipliers.x3Word:
        return 'Potrójna premia słowna';
      default:
        return "Brak premii";
    }
  }

  int get value {
    switch (this) {
      case Multipliers.x2Letter:
        return 2;
      case Multipliers.x2Word:
        return 2;
      case Multipliers.x3Letter:
        return 3;
      case Multipliers.x3Word:
        return 3;
      default:
        return 1;
    }
  }

  Color get color {
    switch (this) {
      case Multipliers.x2Letter:
        return Colors.blue[200];
      case Multipliers.x3Letter:
        return Colors.blue[400];
      case Multipliers.x2Word:
        return Colors.red[100];
      case Multipliers.x3Word:
        return Colors.red[300];
      default:
        return ScrabbleHelper.DIRTY_WHITE;
    }
  }

  MultipliersType get type {
    switch (this) {
      case Multipliers.x2Letter:
        return MultipliersType.letter;
      case Multipliers.x3Letter:
        return MultipliersType.letter;
      case Multipliers.x2Word:
        return MultipliersType.word;
      case Multipliers.x3Word:
        return MultipliersType.word;
      default:
        return MultipliersType.none;
    }
  }
}
