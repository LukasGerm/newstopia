import 'dart:convert';

import 'package:flutter/services.dart';

class Config {
  final String apiKey;
  final String newsApiUrl;
  Config({this.apiKey = "", this.newsApiUrl = ""});
  factory Config.fromJson(Map<String, dynamic> jsonMap) {
    return Config(apiKey: jsonMap["apiKey"], newsApiUrl: jsonMap["newsApiUrl"]);
  }

  /// Loads config
  static Future<Config> loadConfig() async {
    var json = await rootBundle.loadString("lib/assets/config.json");

    return Config.fromJson(jsonDecode(json));
  }
}
