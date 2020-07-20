import 'dart:io';

import 'package:app/helpers/scrabble_helper.dart';
import 'package:archive/archive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class ScrabbleDictionary with ChangeNotifier {
  ScrabbleDictionary() {
    _init();
  }

  String dir;
  Future loadFuture;
  bool isReady = false;
  List<String> _dictionary;

  List<String> get dictionary => [..._dictionary];

  bool isApproved(List<String> chars) {
    var word = chars
        .where((element) => ScrabbleHelper.LETTERS.containsKey(element))
        .join("");
    return dictionary.contains(word);
  }

  Future<void> _init() async {
    if (null == dir) dir = (await getApplicationDocumentsDirectory()).path;
    if (File("$dir/sjp/slowa.txt").existsSync())
      loadFuture = load();
    else
      loadFuture = unzip().then((value) => load());
    loadFuture.whenComplete(() {
      isReady = true;
      notifyListeners();
      debugPrint(dictionary.toString());
    });
  }

  Future<void> unzip() async {
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
    var file = File("$dir/sjp/slowa.txt");
    _dictionary = await file.readAsLines();
  }
}
