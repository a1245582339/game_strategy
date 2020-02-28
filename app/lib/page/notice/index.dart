import 'package:app/utils/http.dart';
import 'package:flutter/material.dart';

class Notice extends StatefulWidget {
  @override
  _NoticeState createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  @override
  void initState() {
    super.initState();
    _read();
  }

  _read() {
    Http().put('/comment/read',
        body: {'time': DateTime.now().millisecondsSinceEpoch.toString()}, auth: true);
  }

  _getComment () {
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(child: Text('test'), onPressed: () {}),
    );
  }
}
