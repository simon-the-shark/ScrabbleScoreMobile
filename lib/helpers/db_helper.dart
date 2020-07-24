import 'package:flutter/widgets.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../widgets/saving_chip.dart';

String transformListToString(List list) {
  var string = "(";
  for (var val in list)
    if (val is String)
      string += '"${val.toString()}", ';
    else
      string += '${val.toString()}, ';
  return string.replaceAll(RegExp(r'..$'), ")");
}

class DatabaseHelper {
  static const DATABASE_NAME = "saves.db";

  static Future<Database> db() async {
    final databasesPath = await getDatabasesPath();
    return await openDatabase(
      join(databasesPath, DATABASE_NAME),
      onCreate: (db, version) {
        db.execute("""CREATE TABLE games (
                      id INTEGER PRIMARY KEY AUTOINCREMENT, 
                      player1 INTEGER, player2 INTEGER, 
                      player3 INTEGER, player4 INTEGER, 
                      player1Name VARCHAR(256), player2Name VARCHAR(256), 
                      player3Name VARCHAR(256), player4Name VARCHAR(256),
                      finished INTEGER NOT NULL, date INTEGER);""");
      },
      version: 2,
    );
  }

  static OverlaySupportEntry showChip() => showOverlay((context, t) {
        return Opacity(
          opacity: t,
          child: const SavingChip(),
        );
      }, duration: Duration.zero);

  static void hideChip(OverlaySupportEntry chip) async {
    await Future.delayed(Duration(milliseconds: 100));
    chip.dismiss();
  }

  static Future<int> insert(Map<String, Object> data) async {
    var chip = showChip();
    final db = await DatabaseHelper.db();
    var id = await db.insert("games", data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    hideChip(chip);
    return id;
  }

  // static Future<void> delete(int id) async {
  //   var chip = showChip();
  //   final db = await DatabaseHelper.db();
  //   await db.delete("games", where: "id = ?", whereArgs: [id]);
  //   hideChip(chip);
  // }

  static Future<void> deleteMultiple(List<int> ids) async {
    var chip = showChip();
    final db = await DatabaseHelper.db();
    var values = transformListToString(ids);
    await db.rawDelete("""DELETE FROM games WHERE id IN $values""");
    hideChip(chip);
  }

  static Future<void> update(
    int id,
    Map<String, Object> data, {
    bool silent = false,
  }) async {
    OverlaySupportEntry chip;
    if (!silent) chip = showChip();
    final db = await DatabaseHelper.db();
    await db.update("games", data, where: 'id = ?', whereArgs: [id]);
    if (!silent) hideChip(chip);
  }

  static Future<void> updateFinished(int id, Map<int, int> points) async {
    var data = {
      "player1": points[1],
      "player2": points[2],
      "player3": points[3],
      "player4": points[4],
      "finished": 1,
      "date": DateTime.now().millisecondsSinceEpoch,
    };
    await update(id, data);
  }

  static Future<Map<String, Object>> fetchLastGame() async {
    final db = await DatabaseHelper.db();
    var result = await db.query("games", orderBy: "date DESC", limit: 1);
    if (!(result.length > 0)) return null;
    return result.first;
  }

  static Future<List<Map<String, dynamic>>> fetchAll() async {
    final db = await DatabaseHelper.db();
    return await db.query("games", orderBy: "date DESC");
  }

  static Future<int> insertGame(Map<int, String> players) async {
    Map<String, Object> data = {
      "player1": 0,
      "player2": 0,
      "player3": 0,
      "player4": 0,
      "finished": 0,
      "date": DateTime.now().millisecondsSinceEpoch,
    };
    players.forEach((key, value) {
      data["player${key}Name"] = value;
    });
    return await insert(data);
  }

  static Future<void> updatePoints(int id, int player, int points) async {
    await update(
      id,
      {"player$player": points},
    );
  }
}
