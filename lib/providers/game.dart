import 'package:flutter/cupertino.dart';

class Game with ChangeNotifier {
  Map<int, String> players = {1: null, 2: null, 3: null, 4: null};

  void setPlayersNames(List<String> names) {
    for (var number in players.keys) players[number] = names[number];
  }
}
