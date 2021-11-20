import 'package:flutter/material.dart';
import 'package:newstopia/types/article.dart';
import 'package:newstopia/widgets/article_content.dart';
import 'package:newstopia/widgets/custom_appbar.dart';

/// screen which gets rendered for an article
/// Gets passed an article
class ArticleScreen extends StatelessWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final article = ModalRoute.of(context)!.settings.arguments as Article;

    return Scaffold(
      appBar: CustomAppbar(title: article.title),
      body: Column(
        children: [
          ArticleContent(
            article: article,
            imageHeight: 200,
          ),
          Container(
              child: Text(article.description,
                  style: const TextStyle(height: 1.75)),
              padding: const EdgeInsets.symmetric(horizontal: 12))
        ],
      ),
    );
    ;
  }
}
