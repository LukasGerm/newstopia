import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newstopia/types/article.dart';
import 'package:newstopia/types/config.dart';

/// Adapter to access the news api
class ArticleAdapter {
  static int limit = 50;
  static Future<ArticleResponse> fetchArticles([int offset = 0]) async {
    Config config = await Config.loadConfig();

    final response = await http.get(Uri.parse(config.newsApiUrl +
        "?limit=" +
        limit.toString() +
        "&languages=en&country=de&access_key=" +
        config.apiKey +
        "&sort=published_desc&offset=" +
        offset.toString()));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      ArticleResponse articles =
          ArticleResponse.fromJson(jsonDecode(response.body));

      articles.articles = articles.articles
          .where((element) => element.image != null && element.author != null)
          .toList();
      return articles;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception("failed to load response");
    }
  }
}
