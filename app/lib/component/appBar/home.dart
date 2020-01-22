import 'package:app/page/search/index.dart';
import 'package:flutter/material.dart';
class HomeBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text('首页'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Search();
              }));
            },
          )
        ],
      );
  }

  @override
  Size get preferredSize => Size(0, 60.0);
}