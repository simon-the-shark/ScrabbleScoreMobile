import 'package:flutter/widgets.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../widgets/saving_chip.dart';

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
      version: 1,
    );
  }

  static OverlaySupportEntry showChip() => showOverlay((context, t) {
        return Opacity(
          opacity: t,
          child: const SavingChip(),
        );
      });

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

  static Future<void> delete(int id) async {
    var chip = showChip();
    final db = await DatabaseHelper.db();
    await db.delete("games", where: "id = ?", whereArgs: [id]);
    hideChip(chip);
  }

  static Future<void> update(int id, Map<String, Object> data) async {
    var chip = showChip();
    final db = await DatabaseHelper.db();
    await db.update("games", data, where: 'id = ?', whereArgs: [id]);
    hideChip(chip);
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

  static Future<List<Map<String, dynamic>>> fetchAll() async {
    final db = await DatabaseHelper.db();
    return await db.query("games");
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
