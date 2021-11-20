import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newstopia/types/article.dart';

/**
 * Content which gets displayed in the article
 */
class ArticleContent extends StatelessWidget {
  final Article article;
  final double imageHeight;

  const ArticleContent(
      {Key? key, required this.article, this.imageHeight = 150})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (article.image != null)
          Row(
            children: [
              Expanded(
                child: Image.network(article.image!,
                    height: imageHeight, fit: BoxFit.cover),
              )
            ],
          ),
        Row(children: [
          Flexible(
            child: Container(
                child: Text(article.title,
                    style: Theme.of(context).textTheme.headline6),
                padding: const EdgeInsets.only(left: 12, top: 16, right: 12)),
          ),
        ]),
        if (article.author != null)
          Row(children: [
            Flexible(
              child: Container(
                  child: Text(
                      "By " +
                          article.author! +
                          " at " +
                          DateFormat("dd.MM.yyyy - kk:mm")
                              .format(article.publishedAt)
                              .toString(),
                      style: Theme.of(context).textTheme.caption),
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 20)),
            ),
          ])
      ],
    );
  }
}
