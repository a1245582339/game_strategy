import 'package:flutter/material.dart';

class Notice extends StatelessWidget {
  const Notice({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('vNoticeNotice', style: TextStyle(fontSize: 50)),
      ),
    );
  }
}
