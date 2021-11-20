/// response which comes directly from the api
class ArticleResponse {
  final Pagination pagination;
  List<Article> articles;
  // maps the data to articles
  static _getArticlesFromJson(List<dynamic> articleList) {
    return articleList.map((article) => Article.fromJson(article)).toList();
  }

  ArticleResponse(this.pagination, this.articles);

  ArticleResponse.fromJson(Map<String, dynamic> json)
      : pagination = Pagination.fromJson(json["pagination"]),
        articles = _getArticlesFromJson(json["data"]);
}

/// The pagination of an article response
class Pagination {
  final int limit;
  final int offset;
  final int count;
  final int total;

  Pagination(this.limit, this.offset, this.count, this.total);

  Pagination.fromJson(Map<String, dynamic> json)
      : limit = json["limit"],
        offset = json["offset"],
        count = json["count"],
        total = json["total"];
}

/// The article itself
class Article {
  final String? author;
  final String title;
  final String description;
  final String url;
  final String source;
  final String? image;
  final String category;
  final String language;
  final String country;
  final DateTime publishedAt;

  Article(this.author, this.title, this.description, this.url, this.source,
      this.image, this.category, this.language, this.country, this.publishedAt);

  Article.fromJson(Map<String, dynamic> json)
      : author = json["author"],
        title = json["title"],
        description = json["description"],
        url = json["url"],
        source = json["source"],
        image = json["image"],
        category = json["category"],
        language = json["language"],
        country = json["country"],
        publishedAt = DateTime.parse(json["published_at"]);
}
