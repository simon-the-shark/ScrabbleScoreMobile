import 'package:app/helpers/db_helper.dart';
import 'package:flutter/cupertino.dart';

class Games with ChangeNotifier {
  List<Map<String, Object>> _games;
  List<Map<String, Object>> get games => [..._games];
  bool get isReady => _games != null;
  int padding = 0;

  Future<void> load() async {
    _games = await DatabaseHelper.fetchAll();
    padding =
        (games.map((e) => e["id"]).toList()..sort()).last.toString().length;
    notifyListeners();
  }
}
