import 'package:flutter/material.dart';
import '../../utils/config.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class Article extends StatefulWidget {
  final id;
  Article({this.id});
  @override
  _ArticleState createState() => _ArticleState(id: id);
}

class _ArticleState extends State<Article> {
  String _articleDetail = '';
  int id;
  _ArticleState({this.id});

  @override
  void initState() {
    super.initState();
    this._getData();
  }

  _getData() async {
    var data = await Http().get('/article/$id');
    print(data["detail"]["content"]);
    setState(() {
      this._articleDetail = data["detail"]["content"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Html(
            data: _articleDetail,
          ),
        ),
      ),
    );
  }
}