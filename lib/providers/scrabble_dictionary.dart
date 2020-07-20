import 'dart:async';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../helpers/scrabble_helper.dart';

class ScrabbleDictionary with ChangeNotifier {
  ScrabbleDictionary() {
    _init();
  }

  String dir;
  Future loadFuture;
  bool isReady = false;

  Future<bool> isApproved(List<String> chars) async {
    var word = chars
        .where((element) => ScrabbleHelper.LETTERS.containsKey(element))
        .join("")
        .toLowerCase();
    var database = await openDatabase("$dir/sjp/sjp-20200717.db", version: 1);
    var result = await database
        .rawQuery("SELECT COUNT(word) FROM words WHERE word='$word' LIMIT 1");
    return result[0].values.toList()[0] > 0;
  }

  Future<void> _init() async {
    if (null == dir) dir = (await getApplicationDocumentsDirectory()).path;
    if (File("$dir/sjp/sjp-20200717.db").existsSync())
      loadFuture = Future.delayed(Duration.zero, () {});
    else
      loadFuture = unzip();
    loadFuture.whenComplete(() {
      isReady = true;
      notifyListeners();
    });
  }

  Future<void> unzip() async {
    var zip = await rootBundle.load("assets/sjp-20200717.zip");
    await compute(_unzip, [zip, dir]);
  }

  static Future<void> _unzip(List args) async {
    var zip = args[0];
    var dir = args[1];
    var archive = ZipDecoder().decodeBytes(
        zip.buffer.asUint8List(zip.offsetInBytes, zip.lengthInBytes));
    for (var file in archive) {
      var fileName = '$dir/sjp/${file.name}';
      if (file.isFile) {
        var outFile = File(fileName);
        print('File:: ' + outFile.path);
        outFile = await outFile.create(recursive: true);
        await outFile.writeAsBytes(file.content);
      }
    }
  }
}
