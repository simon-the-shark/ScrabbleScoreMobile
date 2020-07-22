import 'package:app/helpers/db_helper.dart';
import 'package:flutter/cupertino.dart';

class Games with ChangeNotifier {
  List<Map<String, Object>> _games;
  List<Map<String, Object>> get games => _games == null ? null : [..._games];
  bool get isReady => _games != null;
  int padding = 0;

  Future<void> fetch() async {
    _games = await DatabaseHelper.fetchAll();
    if (_games.isNotEmpty)
      padding =
          (games.map((e) => e["id"]).toList()..sort()).last.toString().length;
    notifyListeners();
  }

  Future<Map<String, Object>> fetchLastGame() async {
    var result = await DatabaseHelper.fetchLastGame();
    if (result["finished"] == 0)
      return result;
    else
      return null;
  }
}
