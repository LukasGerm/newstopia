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

  Future<void> _refreshArticle() async {
    Future<ArticleResponse> freshArticleResponseFuture =
        ArticleAdapter.fetchArticles();
    setState(() {
      articleResponseFuture = freshArticleResponseFuture;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ArticleResponse>(
        future: articleResponseFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Expanded(
              child: RefreshIndicator(
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(20),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.articles.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ArticleTile(
                          article: snapshot.data!.articles[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      height: 40,
                    ),
                  ),
                  onRefresh: _refreshArticle),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        });
  }
}
