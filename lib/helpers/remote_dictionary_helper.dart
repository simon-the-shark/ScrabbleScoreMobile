import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../providers/scrabble_dictionary.dart';

const API_MASTER_URL = "https://scrabble-score.herokuapp.com";

class RemoteDictionaryHelper {
  static final Map<String, bool> cache = {};

  static Future<bool> isApproved(String word) async {
    if (cache.containsKey(word)) return cache[word];
    var url = "$API_MASTER_URL/api/v0/sjp/$word";
    var response = (await Dio().get(url)).data['approved'];
    cache[word] = response;
    return response;
  }

  static Future<void> download(Function(double) onProgress) async {
    var r = await Dio().download(
      "$API_MASTER_URL/download/sjp-20200717.zip",
      "${ScrabbleDictionary.dir}/sjp-20200717.zip",
      onReceiveProgress: (rcv, total) {
        var progress = ((rcv / total) * 100);
        onProgress(progress);
      },
      deleteOnError: true,
    );
    print(r);
  }
}
