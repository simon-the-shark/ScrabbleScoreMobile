import 'package:flutter/cupertino.dart';

class Game with ChangeNotifier {
  Map<int, String> _players = {1: null, 2: null, 3: null, 4: null};
  Map<int, int> _points = {1: 0, 2: 0, 3: 0, 4: 0};
  static const ZERO_POINTS = {1: 0, 2: 0, 3: 0, 4: 0};
  Map<int, List<String>> finalTiles = {1: [], 2: [], 3: [], 4: []};

  Map<int, String> get clearedPlayers => Map<int, String>.from(_players)
    ..removeWhere((key, value) => value == null);

  List<MapEntry<int, String>> get players => clearedPlayers.entries.toList()
    ..sort((a, b) => points[b.key].compareTo(points[a.key]));

  Map<int, int> get points => Map<int, int>.from(_points);

  void setPlayersNames(List<String> names) {
    _points = Map<int, int>.from(ZERO_POINTS);
    for (var number in _players.keys)
      _players[number] =
          names[number] != "" ? names[number] : "< Gracz $number >";
    notifyListeners();
  }

  void addPoints({int player, int points}) {
    _points[player] += points;
    notifyListeners();
  }

  void substractPoints({int player, int points}) {
    _points[player] -= points;
    notifyListeners();
  }
}
