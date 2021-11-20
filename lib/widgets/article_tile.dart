import "package:flutter/material.dart";
import 'package:newstopia/types/article.dart';
import 'package:newstopia/widgets/article_content.dart';

///Shows an article tile with some information to click on
class ArticleTile extends StatelessWidget {
  final Article article;

  const ArticleTile({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/article", arguments: article);
            },
            child: ArticleContent(
              article: article,
            )));
  }
}
