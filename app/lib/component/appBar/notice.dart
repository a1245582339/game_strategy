import 'package:flutter/material.dart';
class NoticeBar extends StatelessWidget implements PreferredSizeWidget {
  const NoticeBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text('通知'),
        actions: <Widget>[
            
        ],
      );
  }

  @override
  Size get preferredSize => Size(0, 60.0);
}