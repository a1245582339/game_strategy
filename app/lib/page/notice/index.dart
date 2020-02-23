import 'package:app/utils/socket.dart';
import 'package:flutter/material.dart';

class Notice extends StatefulWidget {
  @override
  _NoticeState createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
          child: Text('test'),
          onPressed: () {
            Socket();
          }),
    );
  }
}
