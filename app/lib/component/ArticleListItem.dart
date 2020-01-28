import 'package:app/page/article/index.dart';
import 'package:flutter/material.dart';

class ArticleListItem extends StatelessWidget {
  final article;
  ArticleListItem({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            article['title'],
            maxLines: 2,
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
          onTap: () {
            Future.delayed(Duration(milliseconds: 200), () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Article(id: article['id']);
              }));
            });
          },
          contentPadding: EdgeInsets.fromLTRB(16, 10, 16, 10),
        ),
        Divider(
          height: 1,
        )
      ],
    );
  }
}
