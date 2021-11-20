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
  late Future<ArticleResponse> articleResponseFuture;

  @override
  void initState() {
    super.initState();

    /// fetch all articles
    articleResponseFuture = ArticleAdapter.fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ArticleResponse>(
        future: articleResponseFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ArticleListContent(articleResponse: snapshot.data!);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        });
  }
}

/// Shows the articles
class ArticleListContent extends StatelessWidget {
  final ArticleResponse articleResponse;

  const ArticleListContent({Key? key, required this.articleResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(20),
      shrinkWrap: true,
      itemCount: articleResponse.articles.length,
      itemBuilder: (BuildContext context, int index) {
        return ArticleTile(article: articleResponse.articles[index]);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        height: 40,
      ),
    ));
  }
}
