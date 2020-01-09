import 'package:flutter/material.dart';

class Follow extends StatelessWidget {
  const Follow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分类'),
      ),
      body: Container(
        child: Text('Follow', style: TextStyle(fontSize: 50)),
      ),
    );
  }
}
