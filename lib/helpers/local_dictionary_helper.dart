import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../providers/scrabble_dictionary.dart';
import 'file_helper.dart';

class LocalDictionaryHelper {
  static Future<bool> isDownloaded(SharedPreferences preferences) async {
    var dir = ScrabbleDictionary.dir;
    if (dir == null) return false;
    var exist = await File("$dir/sjp-20200717.zip").exists();
    if (exist && !ScrabbleDictionary.isUnpacked) {
      var progress = preferences.getDouble("progress") ?? 0.0;
      if (progress < 100) {
        await FileHelper.delete(File("$dir/sjp-20200717.zip"));
        return false;
      }
      return true;
    }
    return exist;
  }

  static Future<bool> get isUnpacked async {
    var dir = ScrabbleDictionary.dir;
    if (dir == null) return false;
    return await File("$dir/sjp-20200717.db").exists();
  }

  static Future<void> unzip() async {
    var dir = ScrabbleDictionary.dir;
    if (dir == null) return false;
    if (!ScrabbleDictionary.isDownloaded || ScrabbleDictionary.isUnpacked)
      return;
    await FileHelper.unzip(
        file: File("$dir/sjp-20200717.zip"), destinationDir: dir);
  }

  static Future<void> deleteZip() async {
    var dir = ScrabbleDictionary.dir;
    if (dir == null) return false;

    await FileHelper.delete(File("$dir/sjp-20200717.zip"));
  }

  static Future<bool> isApproved(String word) async {
    try {
      var dir = ScrabbleDictionary.dir;
      var database = await openDatabase("$dir/sjp-20200717.db", version: 1);
      var result = await database
          .rawQuery("SELECT COUNT(word) FROM words WHERE word='$word' LIMIT 1");
      return result[0].values.toList()[0] > 0;
    } catch (e) {
      return null;
    }
  }
}
