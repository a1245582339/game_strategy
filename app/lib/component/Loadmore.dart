import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loadmore extends StatefulWidget {
  @override
  _LoadmoreState createState() => _LoadmoreState();
}

class _LoadmoreState extends State<Loadmore> {
  bool loading = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(right: 15.0),
              child: SpinKitRotatingCircle(
                color: Colors.white,
                size: 50.0,
              )),
          (!loading
              ? Text(
                  "正在加载...慌什么慌",
                )
              : Text("正在加载...慌什么慌",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0))),
        ],
      ),
    );
  }
}
