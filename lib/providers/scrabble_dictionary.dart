import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  String get code {
    switch (this) {
      case DictionarySources.remote:
        return "remote";
      case DictionarySources.local:
        return "local";
      default:
        return "none";
    }
  }
}

class ScrabbleDictionary with ChangeNotifier {
  ScrabbleDictionary() {
    getApplicationDocumentsDirectory().then(
      (value) async {
        dir = value.path;
        prefs = await SharedPreferences.getInstance();
        isUnpacked = await LocalDictionaryHelper.isUnpacked;
        isDownloaded = await LocalDictionaryHelper.isDownloaded(prefs);
        isReady = true;
        source = await getSource();
        if (unzipReady) unzip();
        notifyListeners();
      },
    );
  }

  static String dir;
  static bool isDownloaded;
  static bool isUnpacked;
  bool isReady = false;
  SharedPreferences prefs;
  DictionarySources source = DictionarySources.remote;

  Future<void> refresh() async {
    isUnpacked = await LocalDictionaryHelper.isUnpacked;
    isDownloaded = await LocalDictionaryHelper.isDownloaded(prefs);
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

  Future<void> download(Function(double) onProgress) async {
    await RemoteDictionaryHelper.download(onProgress);
    await refresh();
  }

  Future<void> downloadAndUnzip(Function(double) onProgress) async {
    await download(onProgress);
    await unzip();
  }

  void setSource(DictionarySources value) {
    source = value;
    prefs.setString("dictionarySource", value.code);
    notifyListeners();
  }

  Future<DictionarySources> getSource() async {
    var code = prefs.getString("dictionarySource");
    var source =
        DictionarySources.values.indexWhere((element) => element.code == code);
    if (source == -1) return DictionarySources.remote;
    if (DictionarySources.values[source] == DictionarySources.local &&
        !isUnpacked) return DictionarySources.remote;
    return DictionarySources.values[source];
  }
}
