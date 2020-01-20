import 'package:flutter/material.dart';
class CategoryBar extends StatelessWidget implements PreferredSizeWidget {
  const CategoryBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text('分类'),
        actions: <Widget>[
        ],
      );
  }

  @override
  Size get preferredSize => Size(0, 60.0);
}