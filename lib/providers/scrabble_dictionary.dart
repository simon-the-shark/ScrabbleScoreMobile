import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../helpers/local_dictionary_helper.dart';
import '../helpers/remote_dictionary_helper.dart';
import '../helpers/scrabble_helper.dart';

enum DictionarySources {
  remote,
  local,
  none,
}

extension DictionaryExtension on DictionarySources {
  String get label {
    switch (this) {
      case DictionarySources.remote:
        return "Słownik online";
      case DictionarySources.local:
        {
          if (ScrabbleDictionary.isUnpacked) return "Pobrany słownik offline";
          return "Pobierz słownik offline";
        }
      default:
        return "Wyłącz słownik";
    }
  }
}

class ScrabbleDictionary with ChangeNotifier {
  ScrabbleDictionary() {
    getApplicationDocumentsDirectory().then(
      (value) async {
        dir = value.path;
        isDownloaded = await LocalDictionaryHelper.isDownloaded;
        isUnpacked = await LocalDictionaryHelper.isUnpacked;
        isReady = true;
        if (unzipReady) unzip();
        notifyListeners();
      },
    );
  }

  static String dir;
  static bool isDownloaded;
  static bool isUnpacked;
  bool isReady = false;

  DictionarySources source = DictionarySources.remote;

  Future<void> refresh() async {
    isDownloaded = await LocalDictionaryHelper.isDownloaded;
    isUnpacked = await LocalDictionaryHelper.isUnpacked;
    notifyListeners();
  }

  String wordFromChars(List<String> chars) => chars
      .where((element) => ScrabbleHelper.LETTERS.containsKey(element))
      .join("")
      .toLowerCase();

  bool get unzipReady => isReady && isDownloaded && !isUnpacked;

  Future<bool> isApproved(List<String> chars) async {
    if (source == DictionarySources.none) return null;
    var word = wordFromChars(chars);
    if (source == DictionarySources.remote)
      return await RemoteDictionaryHelper.isApproved(word);
    else {
      return await LocalDictionaryHelper.isApproved(word);
    }
  }

  Future<void> unzip() async {
    await LocalDictionaryHelper.unzip();
    await LocalDictionaryHelper.deleteZip();
    await refresh();
  }

  Future<void> download() async {
    await RemoteDictionaryHelper.download();
    await refresh();
  }

  Future<void> downloadAndUnzip() async {
    await download();
    await unzip();
  }

  void setSource(DictionarySources value) {
    source = value;
    notifyListeners();
  }
}
