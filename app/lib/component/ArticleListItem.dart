import 'package:flutter/material.dart';

class ArticleListItem extends StatelessWidget {
  final article;
  ArticleListItem({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        article['title'],
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        article['game'],
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      leading: Image.network(
        article['cover'],
        width: 100,
        fit: BoxFit.cover,
      ),
      trailing: Icon(Icons.chevron_right),
    );
  }
}
