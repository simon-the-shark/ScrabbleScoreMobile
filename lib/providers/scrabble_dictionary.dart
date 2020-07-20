import 'dart:async';
import 'dart:io';

import 'package:app/helpers/scrabble_helper.dart';
import 'package:archive/archive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

bool containes(List args) {
  var word = (args[1] as List)
      .where((element) => ScrabbleHelper.LETTERS.containsKey(element))
      .join("")
      .toLowerCase();
  var file = File("${args[0]}/sjp/slowa.txt");
  var lines = file.readAsLinesSync();
  print(lines);
  print(word);
  return lines.contains(word);
}

class ScrabbleDictionary with ChangeNotifier {
  ScrabbleDictionary() {
    _init();
  }

  String dir;
  Future loadFuture;
  bool isReady = false;
  String dictionary;

  Future<void> _init() async {
    if (null == dir) dir = (await getApplicationDocumentsDirectory()).path;
    if (File("$dir/sjp/slowa.txt").existsSync())
      loadFuture = load();
    else
      loadFuture = unzip().then((value) => load());
    loadFuture.whenComplete(() {
      isReady = true;
      notifyListeners();
    });
  }

  Future<void> unzip() async {
    await compute(_unzip, dir);
  }

  static Future<void> _unzip(String dir) async {
    var zip = await rootBundle.load("assets/sjp-20200717.zip");
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

  Future<void> load() async {
    // dictionary = await compute(_load, dir);
  }

  static Future<String> _load(String dir) async {
    var file = File("$dir/sjp/slowa.txt");
    var lines = file.readAsStringSync();
    return lines;
  }
}
