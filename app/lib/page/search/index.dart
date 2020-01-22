import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SearchState();
  }
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
//      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColor,
      title: TextFileWidget(),
      automaticallyImplyLeading: false,
      actions: <Widget>[
        Center(
            child: InkWell(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "取消",
            ),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ))
      ],
    ));
  }
}

class TextFileWidget extends StatelessWidget {
  Widget buildTextField() {
    //theme设置局部主题
    return TextField(
      cursorColor: Color(0xff666666),
      decoration: InputDecoration(
          fillColor: Colors.white,
          border: InputBorder.none,
          icon: Icon(
            Icons.search,
            color: Color(0xff666666),
          ),
          hintText: "请输入关键字",
          hintStyle: TextStyle(fontSize: 14, color: Color(0xff666666), height: 1.2, textBaseline: TextBaseline.alphabetic)),
          style: TextStyle(fontSize: 14, color: Colors.black),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget editView() {
      return Container(
        //修饰黑色背景与圆角
        decoration: new BoxDecoration(
          border: Border.all(color: Colors.white, width: 1.0), //灰色的一层边框
          color: Colors.white,
          borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
        ),
        alignment: Alignment.center,
        height: 36,
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
        child: buildTextField(),
      );
    }

    var cancleView = new Text("cancle");

    return editView();
  }
}
