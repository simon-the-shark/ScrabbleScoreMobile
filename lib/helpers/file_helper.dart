import 'dart:io';

import 'package:archive/archive.dart';
import 'package:flutter/foundation.dart';

class FileHelper {
  static Future<void> unzip({String destinationDir, File file}) async {
    await compute(_unzip, [file, destinationDir]);
  }

  static Future<void> _unzip(List args) async {
    var zip = args[0];
    var dir = args[1];
    var archive = ZipDecoder().decodeBytes(zip.readAsBytesSync());
    for (var file in archive) {
      var fileName = '$dir/${file.name}';
      if (file.isFile) {
        var outFile = File(fileName);
        print('File:: ' + outFile.path);
        outFile = await outFile.create(recursive: true);
        await outFile.writeAsBytes(file.content);
      }
    }
  }

  static Future<void> delete(File file) async {
    await compute(_delete, file);
  }

  static Future<void> _delete(File file) async {
    print(file.existsSync());
    if (file.existsSync()) await file.delete(recursive: true);
  }
}
