import 'package:flutter/material.dart';
import 'package:newstopia/adapters/article_adapter.dart';
import 'package:newstopia/types/article.dart';

import 'article_tile.dart';

/// List which displays all the state
class ArticleList extends StatefulWidget {
  const ArticleList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ArticleListState();
  }
}

class _ArticleListState extends State<ArticleList> {
  ArticleResponse? articleResponse;
  late bool isLoading = false;
  final int loadingThreshold = 5;
  int offset = 0;
  @override
  void initState() {
    super.initState();
    isLoading = true;

    /// fetch all articles
    ArticleAdapter.fetchArticles().then((value) {
      setState(() {
        isLoading = false;
        articleResponse = value;
        offset = ArticleAdapter.limit;
      });
    });
  }

  Future<void> _refreshArticle() async {
    ArticleResponse freshArticleResponse = await ArticleAdapter.fetchArticles();
    setState(() {
      articleResponse = freshArticleResponse;
    });
  }

  /// Loads new
  _loadAdditionalArticles() async {
    ArticleResponse additionalArticleResponse =
        await ArticleAdapter.fetchArticles(offset);
    ArticleResponse mergedArticleResponse = articleResponse!;

    mergedArticleResponse.articles.addAll(additionalArticleResponse.articles);

    setState(() {
      offset = offset + ArticleAdapter.limit;
      articleResponse = mergedArticleResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading || articleResponse == null) {
      // By default, show a loading spinner.
      return const CircularProgressIndicator();
    }
    return Expanded(
      child: RefreshIndicator(
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(20),
            shrinkWrap: true,
            itemCount: articleResponse!.articles.length,
            itemBuilder: (BuildContext context, int index) {
              if (index ==
                  articleResponse!.articles.length - loadingThreshold) {
                // load new articles
                _loadAdditionalArticles();
              }
              return ArticleTile(article: articleResponse!.articles[index]);
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              height: 40,
            ),
          ),
          onRefresh: _refreshArticle),
    );
  }
}
