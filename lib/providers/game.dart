import 'package:flutter/cupertino.dart';

class Game with ChangeNotifier {
  Map<int, String> _players = {1: null, 2: null, 3: null, 4: null};

  Map<int, String> get players => Map<int, String>.from(_players)
    ..removeWhere((key, value) => value == null);

  void setPlayersNames(List<String> names) {
    for (var number in _players.keys) _players[number] = names[number];
    notifyListeners();
  }
}
