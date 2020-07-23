import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../providers/scrabble_dictionary.dart';

const API_MASTER_URL = "https://scrabble-score.herokuapp.com";

class RemoteDictionaryHelper {
  static final Map<String, bool> cache = {};

  static Future<bool> isApproved(String word) async {
    if (cache.containsKey(word)) return cache[word];
    var url = "$API_MASTER_URL/api/v0/sjp/$word";
    var response = await http.get(url);
    var text = utf8.decode(response.bodyBytes);
    var approved = json.decode(text)['approved'];
    cache[word] = approved;
    return approved;
  }

  static Future<File> download() async {
    var req = await http.Client()
        .get(Uri.parse("$API_MASTER_URL/download/sjp-20200717.zip"));
    var file = File('${ScrabbleDictionary.dir}/sjp-20200717.db');
    return file.writeAsBytes(req.bodyBytes);
  }
}
