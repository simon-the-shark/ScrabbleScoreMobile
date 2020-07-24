import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    var prefs = await SharedPreferences.getInstance();
    await Dio().download(
      "$API_MASTER_URL/download/sjp-20200717.zip",
      "${ScrabbleDictionary.dir}/sjp-20200717.zip",
      onReceiveProgress: (rcv, total) {
        var progress = ((rcv / total) * 100);
        if (progress == 100.0 || progress.floor() % 10 == 0)
          prefs.setDouble("progress", progress);
        onProgress(progress);
      },
      deleteOnError: true,
    );
    prefs.setDouble("progress", 100);
    print(prefs.getDouble("progress"));
  }
}
