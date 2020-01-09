import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loadmore extends StatefulWidget {
  @override
  _LoadmoreState createState() => _LoadmoreState();
}

class _LoadmoreState extends State<Loadmore> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(right: 15.0),
              child: SpinKitDoubleBounce(
                color: Theme.of(context).primaryColor,
                size: 20,
                controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 800))
              )),
        ],
      ),
    );
  }
}
